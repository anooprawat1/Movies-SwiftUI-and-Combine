//
//  Endpoint.swift
//  Movies-SwiftUI-and-Combine
//
//  Created by Anoop on 09.07.22.
//

import Foundation

public protocol Endpoint {
    var scheme:String {get}
    var host: String{get}
    var path: String {get}
    var method: RequestMethod {get}
    var queryItems: [URLQueryItem]? {get}
    var headers: [String: String]? {get}
    var body: [String: String]? {get}
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    var host: String {
        return "api.themoviedb.org"
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var body: [String : String]? {
        return nil
    }
    
    var urlRequest: URLRequest? {
        var urlComponent = URLComponents()
        urlComponent.scheme = scheme
        urlComponent.host = host
        urlComponent.path = path
        urlComponent.queryItems = queryItems
        if let url = urlComponent.url {
            var request = URLRequest(url: url)
            if headers != nil {
                request.allHTTPHeaderFields = headers
            }
            if body != nil, let data = try? JSONSerialization.data(withJSONObject: body as Any) {
                request.httpBody = data
            }
            return request
        }
        return nil
    }
}
