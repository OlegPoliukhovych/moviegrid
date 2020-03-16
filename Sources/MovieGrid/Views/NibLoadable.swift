//
//  NibLoadable.swift
//  MovieGrid
//
//  Created by Oleg Poliukhovych on 3/15/20.
//  Copyright © 2020 Oleg Poliukhovych. All rights reserved.
//

import UIKit

protocol NibLoadable { }

extension UIView: NibLoadable { }

extension NibLoadable where Self: UIView {

    static func loadFromNib(nibNameOrNil: String? = nil) -> Self {
        let dynamicMetatype = Self.self
        let bundle = Bundle(for: dynamicMetatype)
        let nib = UINib(nibName: "\(dynamicMetatype)", bundle: bundle)

        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("Could not load view from nib file.")
        }

        return view
    }
}
