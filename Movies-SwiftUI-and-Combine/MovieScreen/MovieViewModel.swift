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
    @Published var movieList = [MovieRowViewModel]()
    var currentPageIndex: Int
    var cancellables = Set<AnyCancellable>()

    init(movieService: MovieService) {
        self.movieService = movieService
        self.currentPageIndex = 1
        self.discoverMovies()
    }
    
    private func discoverMovies() {
        movieService.discoverMovie(pageCount: currentPageIndex).sink { error in
            print(error)
        } receiveValue: { [weak self] movieResponse in
            DispatchQueue.main.async {
                self?.movieList.append(contentsOf: movieResponse.results.map{MovieRowViewModel(id: $0.id,title: $0.title, imageUrl: $0.imageUrl, description: $0.overview)})
            }
            
        }.store(in: &cancellables)
    }
    
    func currentMovieScroll(_ movie: MovieRowViewModel) {
        if let i = movieList.lastIndex(where: { $0.id == movie.id }) {
            if 0...3 ~= movieList.count - i {
                currentPageIndex+=1
                self.discoverMovies()
            }
        }
    }
}
