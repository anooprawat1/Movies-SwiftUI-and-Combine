//
//  MovieViewModel.swift
//  Movies-SwiftUI-and-Combine
//
//  Created by Anoop on 08.07.22.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject {
    var movieService: MovieService
    private var discoverData = MovieData(index: 1, movies: [MovieRowViewModel]())
    private var searchData = MovieData(index: 1, movies: [MovieRowViewModel]())
    @Published var movieList = [MovieRowViewModel]()
    @Published var searchText = ""
    private let searchMoviePublisher = PassthroughSubject<(String,Int), Never>()
    private let discoverMoviePublisher = CurrentValueSubject<Int, Never>(1)
    private let scrollPublisher = PassthroughSubject<Int, Never>()


    var cancellables = Set<AnyCancellable>()

    init(movieService: MovieService) {
        self.movieService = movieService
        
        $searchText.debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map({$0})
            .sink { [weak self] text in
                self?.searchMovieForNewQuery(text)
             }.store(in: &cancellables)
        
        searchMoviePublisher.sink { [weak self] (queryText, pageCount) in
            self?.searchMovie(queryText: queryText, pageCount: pageCount)
            }.store(in: &cancellables)
    
        
        discoverMoviePublisher.sink { [weak self] pageCount in
            self?.discoverMovie(pageCount)
            }.store(in: &cancellables)
    
    }
    
    private func searchMovieForNewQuery(_ queryText: String) {
        if queryText.isEmpty {
            self.updateMovies()
        } else {
            self.searchData.movies.removeAll()
            self.searchData.index = 1
            self.searchMoviePublisher.send((queryText, self.searchData.index))
        }
    }
    
    private func searchMovie(queryText: String, pageCount: Int) {
        self.movieService.searchMovie(query: queryText, pageCount: pageCount)
            .receive(on: DispatchQueue.main)
            .sink { error in
                print(error)
            } receiveValue: { [weak self] movieResponse  in
                let results = movieResponse.results
                    .map{MovieRowViewModel(id: $0.id,title: $0.title, imageUrl: $0.imageUrl, description: $0.overview)}
                self?.searchData.movies.append(contentsOf: results)
                self?.updateMovies()
            }.store(in: &self.cancellables)
    }
    
    private func discoverMovie(_ pageCount: Int) {
        movieService.discoverMovie(pageCount: pageCount)
            .receive(on: DispatchQueue.main)
            .sink { error in
                print(error)
            } receiveValue: {[weak self] movieResponse in
                let results = movieResponse.results
                    .map{MovieRowViewModel(id: $0.id,title: $0.title, imageUrl: $0.imageUrl, description: $0.overview)}
                self?.discoverData.movies.append(contentsOf: results)
                self?.updateMovies()
            }.store(in: &self.cancellables)
    }
    
    private func updateMovies() {
        self.movieList = self.searchText.isEmpty ?  self.discoverData.movies: self.searchData.movies
    }
    
    func movieDidAppear(_ movie: MovieRowViewModel) {
        if let index = movieList.lastIndex(where: { $0.id == movie.id }) {
            if movieList.count - index == 10 {
                if self.searchText == "" {
                    self.discoverData.index += 1
                    self.discoverMoviePublisher.send(self.discoverData.index)
                } else {
                    self.searchData.index += 1
                    self.searchMoviePublisher.send((self.searchText, self.searchData.index))
                }
            }
        }
    }
}

struct MovieData {
    var index: Int
    var movies: [MovieRowViewModel]
}
