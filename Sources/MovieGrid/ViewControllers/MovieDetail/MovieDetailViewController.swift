//
//  MovieDetailViewController.swift
//  MovieGrid
//
//  Created by Oleg Poliukhovych on 3/15/20.
//  Copyright © 2020 Oleg Poliukhovych. All rights reserved.
//

import UIKit
import Nuke

final class MovieDetailViewController: UIViewController {

    @IBOutlet private weak var bgImageView: UIImageView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var infoStackView: UIStackView!
    @IBOutlet private weak var fullTitleLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!

    var viewModel: MovieDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupWithViewModel()
    }

    private func setupUI() {
        posterImageView.layer.cornerRadius = 8
    }

    private func setupWithViewModel() {
        title = viewModel.title
        if let posterUrl = viewModel.posterUrl {
            loadImage(with: posterUrl, into: bgImageView)
            loadImage(with: posterUrl, into: posterImageView)
        }
        viewModel.infoComponents.forEach { component in
            let view: RatingView = .loadFromNib()
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.translatesAutoresizingMaskIntoConstraints = false
            view.configure(with: component)
            infoStackView.addArrangedSubview(view)
        }
        fullTitleLabel.text = viewModel.titleWithYear
        overviewLabel.text = viewModel.overview
    }
}
