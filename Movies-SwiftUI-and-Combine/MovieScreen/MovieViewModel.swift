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
    var cancellables = Set<AnyCancellable>()

    init(movieService: MovieService) {
        self.movieService = movieService
        self.discoverMovies()
    }
    
    func discoverMovies(pageCount: Int = 1) {
        movieService.discoverMovie(pageCount: pageCount).sink { error in
            print(error)
        } receiveValue: { [weak self] movieResponse in
            DispatchQueue.main.async {
                for movie in movieResponse.results {
                    self?.movieList.append(MovieRowViewModel(item: movie))
                }
            }
            
        }.store(in: &cancellables)

    }
}
