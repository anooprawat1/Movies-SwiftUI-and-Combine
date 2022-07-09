//
//  MovieRowViewModel.swift
//  Movies-SwiftUI-and-Combine
//
//  Created by Anoop on 08.07.22.
//

import Foundation

struct MovieRowViewModel: Identifiable {
    var id: Int
    var title: String
    var imageUrl: URL?
    var description: String
    
    init(item: MovieResponse.Movie) {
        self.id = item.id
        self.title = item.title
        self.imageUrl = URL(string: "https://image.tmdb.org/t/p/original" + (item.imageUrl ?? ""))
        self.description = item.overview
    }
}
