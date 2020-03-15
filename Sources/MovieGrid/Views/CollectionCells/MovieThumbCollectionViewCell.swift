//
//  MovieThumbCollectionViewCell.swift
//  MovieGrid
//
//  Created by Oleg Poliukhovych on 3/15/20.
//  Copyright © 2020 Oleg Poliukhovych. All rights reserved.
//

import UIKit

class MovieThumbCollectionViewCell: UICollectionViewCell, CellDescribable {

    @IBOutlet private weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
    }

    func configure(with viewModel: MovieThumbViewModel) {

    }

}
