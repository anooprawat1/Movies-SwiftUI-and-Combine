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
    
    init(id: Int, title: String, imageUrl: String?, description: String) {
        self.id = id
        self.title = title
        self.imageUrl = URL(string: "https://image.tmdb.org/t/p/original" + (imageUrl ?? "" ))
        self.description = description
    }
}
