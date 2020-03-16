//
//  MoviesListFlowLayout.swift
//  MovieGrid
//
//  Created by Oleg Poliukhovych on 3/15/20.
//  Copyright © 2020 Oleg Poliukhovych. All rights reserved.
//

import UIKit

class MoviesListFlowLayout: UICollectionViewFlowLayout {

    private var columns: Int = 1
    private var cellPadding = CGFloat()
    private var ratio = CGFloat()

    convenience init(numberOfColumns: Int,
                     cellPadding: CGFloat,
                     ratio: CGFloat,
                     sectionInset: UIEdgeInsets = .zero) {
        self.init()
        self.cellPadding = cellPadding
        self.columns = numberOfColumns
        self.ratio = ratio
        self.sectionInset = sectionInset
    }

    private func configureLayout() {
        guard let collectionView = collectionView else { return }
        var itemWidth = CGFloat()

        let insets = sectionInset.left + sectionInset.right
        itemWidth = (collectionView.bounds.width - insets - (cellPadding * (CGFloat(columns) - 1))) / CGFloat(columns)
        minimumLineSpacing = cellPadding
        minimumInteritemSpacing = cellPadding
        itemSize = CGSize(width: itemWidth, height: itemWidth * ratio)

    }

    func setNumberOfColumns(_ columns: Int) {
        self.columns = columns
    }

    override func invalidateLayout() {
        super.invalidateLayout()
        configureLayout()
    }

}
