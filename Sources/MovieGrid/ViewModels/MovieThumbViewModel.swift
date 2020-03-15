//
//  MovieThumbViewModel.swift
//  MovieGrid
//
//  Created by Oleg Poliukhovych on 3/15/20.
//  Copyright © 2020 Oleg Poliukhovych. All rights reserved.
//

import Foundation

struct MovieThumbViewModel {

    let posterUrl: URL?

    init(model: Movie) {
        guard let posterPath = model.posterPath,
            let baseUrl = URL(string: APIPaths.postersPath.rawValue) else {
            posterUrl = nil
            return
        }
        posterUrl = baseUrl.appendingPathComponent(posterPath)
    }
}
