//
//  RatingView.swift
//  MovieGrid
//
//  Created by Oleg Poliukhovych on 3/15/20.
//  Copyright © 2020 Oleg Poliukhovych. All rights reserved.
//

import UIKit

class RatingView: UIView {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    func configure(with viewModel: MovieInfoComponentViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.info
    }

}
