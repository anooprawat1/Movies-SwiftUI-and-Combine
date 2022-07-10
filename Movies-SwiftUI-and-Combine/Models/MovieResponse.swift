//
//  Response.swift
//  Movies-SwiftUI-and-Combine
//
//  Created by Anoop on 08.07.22.
//

import Foundation

struct MovieResponse: Codable {
    struct Movie: Codable, Identifiable {
        let id: Int
        let isAdult: Bool?
        let title: String
        let overview: String
        let popularity: Float
        let releaseDate: Date?
        let imageUrl: String?
        let voteAverage: Float?
        let voteCount: Int?
        
        private enum CodingKeys: String, CodingKey {
                case id
                case isAdult = "adult"
                case title
                case overview
                case popularity
                case releaseDate
                case imageUrl = "poster_path"
                case voteAverage
                case voteCount
            }
    }
    let page: Int
    let results: [Movie]
}
