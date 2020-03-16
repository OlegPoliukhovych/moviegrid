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

    private var isNeedToUpdateCollectionLayout = false
    private var numberOfColumns: Int {
        UIApplication.shared.statusBarOrientation.isLandscape ? 4 : 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupViewModel()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isNeedToUpdateCollectionLayout {
            updateCollectionLayout()
            isNeedToUpdateCollectionLayout = false
        }
    }

    private func setupCollectionView() {
        collectionView.register(MovieThumbCollectionViewCell.nib,
                                forCellWithReuseIdentifier: MovieThumbCollectionViewCell.identifier)
        let flowLayout = MoviesListFlowLayout(numberOfColumns: numberOfColumns,
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

    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] _ in
            guard self?.isVisible == true else {
                self?.isNeedToUpdateCollectionLayout = true
                return
            }
            self?.updateCollectionLayout()
        }, completion: nil)
    }

    private func updateCollectionLayout() {
        guard let collectionViewLayout = self.collectionView.collectionViewLayout as? MoviesListFlowLayout else {
            return
        }
        collectionViewLayout.setNumberOfColumns(numberOfColumns)
        collectionViewLayout.invalidateLayout()
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieDetailViewModel = viewModel.movieDetailViewModel(at: indexPath.item) else { return }
        performSegue(withIdentifier: "showDetail", sender: movieDetailViewModel)
    }
}

extension MoviesListViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? MovieDetailViewController,
            let movieDeatilViewModel = sender as? MovieDetailViewModel else { return }
        vc.viewModel = movieDeatilViewModel
    }
}
