//
//  MoviesResponse.swift
//  MovieGrid
//
//  Created by Oleg Poliukhovych on 3/15/20.
//  Copyright © 2020 Oleg Poliukhovych. All rights reserved.
//

import Foundation

struct MoviesResponse: Decodable {
    let results: [Movie]
    let page: Int
    let totalPages: Int
}
