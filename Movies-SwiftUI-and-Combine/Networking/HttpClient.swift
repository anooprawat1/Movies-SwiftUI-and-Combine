//
//  ApiManager.swift
//  Movies-SwiftUI-and-Combine
//
//  Created by Anoop on 09.07.22.
//

import Foundation
import Combine

protocol HttpClientProtocol {
    func fetchData<T: Decodable>(endpoint: Endpoint, responseModel: T.Type, decoder: JSONDecoder) -> Future<T, RequestError>
}

class HttpClient: HttpClientProtocol {
    var cancellables = Set<AnyCancellable>()
    static var shared = HttpClient()
    private init() {
        
    }

    func fetchData<T: Decodable>(endpoint: Endpoint, responseModel: T.Type, decoder: JSONDecoder = .init()) -> Future<T, RequestError> {
        return Future() { [weak self] promise in
            guard let self = self, let urlRequest = endpoint.urlRequest else { return promise(.failure(.invalidURL))}
            URLSession.shared.dataTaskPublisher(for: urlRequest)
                .tryMap { (data, response) -> Data in
                    guard  let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw RequestError.unexpectedStatusCode
                    }
                    return data
                }
                .decode(type: responseModel, decoder: decoder)
                .sink { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case _ as DecodingError:
                            promise(.failure(.decode))
                        default:
                            promise(.failure(.unknown))
                        }
                    }
                  
                } receiveValue: { promise(.success($0))}
                .store(in: &self.cancellables)
        }
       
    }
}
