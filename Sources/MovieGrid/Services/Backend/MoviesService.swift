//
//  MoviesService.swift
//  MovieGrid
//
//  Created by Oleg Poliukhovych on 3/15/20.
//  Copyright © 2020 Oleg Poliukhovych. All rights reserved.
//

import Foundation

final class MoviesService {

    private let nowPlayingPath = "/3/movie/now_playing"

    private let client = HttpClient()

    func fetchMovies(page: Int,
                     completion: @escaping (Result<MoviesResponse, Error>) -> Void) {
        let request = Request(path: nowPlayingPath,
                              queryItems: [URLQueryItem(name: "page", value: "\(page)")])

        client.get(request: request) { result in
            completion(result)
        }
    }
}
