//
//  MoviesListViewController.swift
//  MovieGrid
//
//  Created by Oleg Poliukhovych on 3/14/20.
//  Copyright © 2020 Oleg Poliukhovych. All rights reserved.
//

import UIKit

final class MoviesListViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    private var latestDisplayedItemIndex = 0

    private var viewModel: MoviesListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupViewModel()
    }

    private func setupCollectionView() {
        collectionView.register(MovieThumbCollectionViewCell.nib,
                                forCellWithReuseIdentifier: MovieThumbCollectionViewCell.identifier)
        let flowLayout = MoviesListFlowLayout(numberOfColumns: 2,
                                              cellPadding: 20,
                                              ratio: 1.5,
                                              sectionInset: UIEdgeInsets(top: 25, left: 25, bottom: 16, right: 25))
        collectionView.collectionViewLayout = flowLayout
    }

    private func setupViewModel() {
        viewModel = MoviesListViewModel(service: MoviesService())
        title = viewModel.title
        viewModel.listUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        viewModel.fetchMovies()
    }

}

extension MoviesListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = MovieThumbCollectionViewCell.identifier
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                 for: indexPath) as? MovieThumbCollectionViewCell else {
                                    fatalError("no registered cell with identifier: \(cellIdentifier)")
        }
        if let thumbViewModel = viewModel.movieThumb(at: indexPath.item) {
            cell.configure(with: thumbViewModel)
        }
        return cell
    }

}

extension MoviesListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard
            indexPath.item >= collectionView.numberOfItems(inSection: indexPath.section) - 2,
            indexPath.item > latestDisplayedItemIndex else {
                return
        }
        latestDisplayedItemIndex = collectionView.numberOfItems(inSection: indexPath.section) - 1
        viewModel.fetchMovies()
    }
}
