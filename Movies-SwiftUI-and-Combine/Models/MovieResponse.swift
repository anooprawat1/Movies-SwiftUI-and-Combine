//
//  Response.swift
//  Movies-SwiftUI-and-Combine
//
//  Created by Anoop on 08.07.22.
//

import Foundation

struct MovieResponse: Decodable {
    struct Movie: Decodable, Identifiable {
        let id: Int
        let isAdult: Bool?
        let title: String
        let overview: String
        let popularity: Float
        let releaseDate: Date?
        let imageUrl: String?
        let voteAverage: Float?
        let voteCount: Int?
    }
    let page: Int
    let results: [Movie]
}
