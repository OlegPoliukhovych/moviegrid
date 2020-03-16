//
//  AppDelegate.swift
//  MovieGrid
//
//  Created by Oleg Poliukhovych on 3/14/20.
//  Copyright © 2020 Oleg Poliukhovych. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        setupAppearance()
        setupRootVC()

        return true
    }

}

// MARK: Helpers

/// Provided logic better to move to Coordinator or another navigation solution, for example Router

private extension AppDelegate {

    func setupAppearance() {
        UINavigationBar.appearance().tintColor = UIColor.gray
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .light)
        ]
    }

    func setupRootVC() {
        let storyboard = UIStoryboard(name: "MoviesList", bundle: nil)
        let rootVC = storyboard.instantiateInitialViewController()!
        let navContrroller = UINavigationController(rootViewController: rootVC)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = navContrroller
    }
}
