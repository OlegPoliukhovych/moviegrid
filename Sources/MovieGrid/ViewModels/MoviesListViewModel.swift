//
//  MoviesListViewModel.swift
//  MovieGrid
//
//  Created by Oleg Poliukhovych on 3/15/20.
//  Copyright © 2020 Oleg Poliukhovych. All rights reserved.
//

import Foundation

final class MoviesListViewModel {

    private let service: MoviesService
    private var currentPage = 0
    private var totalPagesCount = 1

    let title = "Latest Movies"
    private var movieViewModels = [MovieThumbViewModel]() {
        didSet {
            listUpdated?()
        }
    }

    var listUpdated: (() -> Void)?

    init(service: MoviesService) {
        self.service = service
    }

    private func update(with response: MoviesResponse) {
        currentPage = response.page
        totalPagesCount = response.totalPages
        movieViewModels.append(contentsOf: response.results.map(MovieThumbViewModel.init))
    }

    func fetchMovies() {
        guard currentPage < totalPagesCount else {
            return
        }
        service.fetchMovies(page: currentPage + 1) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let moviesResponse):
                self.update(with: moviesResponse)
            case .failure:
                // handle error somehow
                break
            }
        }
    }

    // MARK: Helpers

    var numberOfCells: Int {
        return movieViewModels.count
    }

    func movieThumb(at index: Int) -> MovieThumbViewModel? {
        guard index < movieViewModels.count else { return nil }
        return movieViewModels[index]
    }

}
