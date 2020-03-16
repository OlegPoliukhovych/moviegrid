//
//  MovieDetailViewModel.swift
//  MovieGrid
//
//  Created by Oleg Poliukhovych on 3/15/20.
//  Copyright © 2020 Oleg Poliukhovych. All rights reserved.
//

import Foundation

struct MovieDetailViewModel {

    let title: String
    let posterUrl: URL?
    let infoComponents: [MovieInfoComponentViewModel]
    let titleWithYear: String
    let overview: String

    init(model: Movie) {
        title = model.title

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM DD, YYYY"
        dateFormatter.string(from: model.releaseDate)

        infoComponents = [
            MovieInfoComponentViewModel(title: "Score:", info: String(model.voteAverage)),
            MovieInfoComponentViewModel(title: "Popularity:", info: String(model.popularity)),
            MovieInfoComponentViewModel(title: "Release Date:",
                                        info: dateFormatter.string(from: model.releaseDate))
        ]

        dateFormatter.dateFormat = "YYYY"
        dateFormatter.string(from: model.releaseDate)

        titleWithYear = model.title + " (\(dateFormatter.string(from: model.releaseDate)))"
        overview = model.overview
        guard let posterPath = model.posterPath else {
            posterUrl = nil
            return
        }
        posterUrl = Constants.postersPath.appendingPathComponent(posterPath)
    }
}

struct MovieInfoComponentViewModel {
    let title: String
    let info: String
}
