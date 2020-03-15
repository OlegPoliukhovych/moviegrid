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
                                              itemHeight: 300,
                                              sectionInset: UIEdgeInsets(top: 16, left: 25, bottom: 16, right: 25))
        collectionView.collectionViewLayout = flowLayout
    }

    private func setupViewModel() {
        viewModel = MoviesListViewModel(service: MoviesService())
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieThumbCollectionViewCell.identifier,
                                                      for: indexPath)

        return cell
    }

}
