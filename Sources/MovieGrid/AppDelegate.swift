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

        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.darkGray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .light)]

        let storyboard = UIStoryboard(name: "MoviesList", bundle: nil)
        let rootVC = storyboard.instantiateInitialViewController()!
        let navContrroller = UINavigationController(rootViewController: rootVC)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = navContrroller

        return true
    }

}
