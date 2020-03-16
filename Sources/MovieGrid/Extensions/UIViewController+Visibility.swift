//
//  UIViewController+Visibility.swift
//  MovieGrid
//
//  Created by Oleg Poliukhovych on 3/16/20.
//  Copyright © 2020 Oleg Poliukhovych. All rights reserved.
//

import UIKit

extension UIViewController {

    var isVisible: Bool {
        return viewIfLoaded?.window != nil
    }
}
