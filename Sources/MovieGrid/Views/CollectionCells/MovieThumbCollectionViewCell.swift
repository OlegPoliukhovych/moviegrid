//
//  MovieThumbCollectionViewCell.swift
//  MovieGrid
//
//  Created by Oleg Poliukhovych on 3/15/20.
//  Copyright © 2020 Oleg Poliukhovych. All rights reserved.
//

import UIKit
import Nuke

class MovieThumbCollectionViewCell: UICollectionViewCell, CellDescribable {

    @IBOutlet private weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }

    override func prepareForReuse() {
        imageView.image = nil
    }

    func configure(with viewModel: MovieThumbViewModel) {
        guard let url = viewModel.posterUrl else { return }
        loadImage(with: url, into: imageView)
    }

}
