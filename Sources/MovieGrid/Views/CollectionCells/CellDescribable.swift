//
//  CellDescribable.swift
//  MovieGrid
//
//  Created by Oleg Poliukhovych on 3/15/20.
//  Copyright © 2020 Oleg Poliukhovych. All rights reserved.
//

import UIKit

/// Protocol that helps provide cell info
protocol CellDescribable {

    /// nib of the cell
    static var nib: UINib? { get }

    /// identifier of the cell
    static var identifier: String { get }
}

extension CellDescribable {

    static var nib: UINib? {
        if Bundle.main.path(forResource: String(describing: self), ofType: "nib") != nil {
            return UINib(nibName: String(describing: self), bundle: nil)
        }
        return nil
    }

    static var identifier: String {
        return String(describing: self)
    }
}
