//
//  MoviesEndpoint.swift
//  Movies-SwiftUI-and-Combine
//
//  Created by Anoop on 09.07.22.
//

import Foundation

enum MoviesEndpoint {
    case discover(page: Int)
    case search(query: String, page: Int)
}

extension MoviesEndpoint: Endpoint {
    var path: String {
        switch self {
        case .discover:
            return "/3/discover/movie"
        case .search:
            return "/3/search/movie"
        }
    }
    
    var method: RequestMethod {
        return RequestMethod.get
    }
    
    var queryItems: [URLQueryItem]? {
        var urlQueryItems = [URLQueryItem]()
        let queryItem = URLQueryItem(name: "api_key", value: "a88f75696733e2f7e60e7c9cb6b81a34")
        urlQueryItems.append(queryItem)
        switch self {
        case .discover(let pageCount):
            let queryItem = URLQueryItem(name: "page", value: String(pageCount))
            urlQueryItems.append(queryItem)
        case .search(let tuple):
            let (query, pageCount) = tuple
            let queryItem = URLQueryItem(name: "query", value: query)
            urlQueryItems.append(queryItem)
            let pageQueryItem = URLQueryItem(name: "page", value: String(pageCount))
            urlQueryItems.append(pageQueryItem)

        }
        return urlQueryItems
    }
    
}
