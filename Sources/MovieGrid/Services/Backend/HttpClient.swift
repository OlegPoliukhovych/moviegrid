//
//  HttpClient.swift
//  MovieGrid
//
//  Created by Oleg Poliukhovych on 3/15/20.
//  Copyright © 2020 Oleg Poliukhovych. All rights reserved.
//

import Foundation

struct Request {
    let path: String
    let queryItems: [URLQueryItem]?
}

enum HttpError: Error {
    case invalidUrl
    case response(Error)
    case noData
}

final class HttpClient {

    private var baseUrlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: "ebea8cfca72fdff8d2624ad7bbf78e4c")
        ]
        return components
    }

    // MARK: Public API

    func get<T: Decodable>(request: Request,
                           completion: @escaping (Result<T, Error>) -> Void) {

        var components = baseUrlComponents
        components.path = request.path
        if let queryItems = request.queryItems {
            components.queryItems?.append(contentsOf: queryItems)
        }

        guard let url = components.url else {
            completion(.failure(HttpError.invalidUrl))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in

            if let err = error {
                completion(.failure(err))
                return
            }
            guard let data = data else {
                completion(.failure(HttpError.noData))
                return
            }
            do {
                let result = try DecodableParser.parse(data: data, to: T.self)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
