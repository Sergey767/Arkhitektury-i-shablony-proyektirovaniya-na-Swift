//
//  AppStartConfigurator.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 19.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppStartManager {
    
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        
        let navVC = createConfiguredNavigationController()
        navVC.viewControllers = [createtabbar()]
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
    
    func createConfiguredNavigationController() -> UINavigationController {
        let navVC = UINavigationController()
        navVC.navigationBar.barTintColor = UIColor.varna
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navVC
    }
    
    func createSearchAppsNavigationViewController() -> UINavigationController {
        let searchAppsViewController = SearchBuilder.build()
        searchAppsViewController.view.backgroundColor = UIColor.varna
        searchAppsViewController.title = "Search applications"
        return UINavigationController(rootViewController: searchAppsViewController)
    }

    func createSearchSongsNavigationViewController() -> UINavigationController {
        let searchSongsViewController = SearchSongBuilder.build()
        searchSongsViewController.view.backgroundColor = UIColor.varna
        searchSongsViewController.title = "Search Song"
        return UINavigationController(rootViewController: searchSongsViewController)
    }
    
    func createtabbar() -> UITabBarController {
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = .varna
        tabbar.viewControllers = [createSearchAppsNavigationViewController(), createSearchSongsNavigationViewController()]
        return tabbar
    }
}
