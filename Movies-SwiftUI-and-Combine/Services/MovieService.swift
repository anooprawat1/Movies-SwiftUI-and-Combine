//
//  MovieServices.swift
//  Movies-SwiftUI-and-Combine
//
//  Created by Anoop on 09.07.22.
//

import Foundation
import Combine

protocol MovieServiceProtocol {
    func discoverMovie(pageCount: Int) -> AnyPublisher<MovieResponse, RequestError>
    func searchMovie(query: String, pageCount: Int) -> AnyPublisher<MovieResponse, RequestError>
}

struct MovieService: MovieServiceProtocol {
    
    var jsonDecoder: JSONDecoder {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
    
    func discoverMovie(pageCount: Int) -> AnyPublisher<MovieResponse, RequestError> {
        
        HttpClient.shared.fetchData(endpoint: MoviesEndpoint.discover(page: pageCount), responseModel: MovieResponse.self, decoder: jsonDecoder).eraseToAnyPublisher()
    }
    
    func searchMovie(query: String, pageCount: Int) -> AnyPublisher<MovieResponse, RequestError> {
        HttpClient.shared.fetchData(endpoint: MoviesEndpoint.search(query: query, page: pageCount), responseModel: MovieResponse.self, decoder: jsonDecoder).eraseToAnyPublisher()
    }
    
    
}
