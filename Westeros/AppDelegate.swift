//
//  AppDelegate.swift
//  Westeros
//
//  Created by Alexandre on 6/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var seasonDetailNavigation: UINavigationController!
    var houseDetailNavigation: UINavigationController!
    let splitVC = UISplitViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Model
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        let episodes = Repository.local.episodes
        
        // OLD INTERFACE
        // Controllers
        // Master
        let houseListVC = HouseListTableViewController(model: houses)
        let lastHouseSelected = houseListVC.lastSelectedHouse() // reset
        let houseDetailViewController = HouseDetailViewController(model: lastHouseSelected)
        
        let seasonListViewController = SeasonListViewController(model: seasons)
        let seasonDetailViewController = SeasonDetailViewController(model: seasons.first!)
        
        houseListVC.delegate = houseDetailViewController
        seasonListViewController.delegate = seasonDetailViewController
        
        var houseListNav: UINavigationController!
        var seasonListNav: UINavigationController!
        
        houseListNav = houseListVC.wrappedInNavigation()
        seasonListNav = seasonListViewController.wrappedInNavigation()
        houseDetailNavigation = houseDetailViewController.wrappedInNavigation()
        seasonDetailNavigation = seasonDetailViewController.wrappedInNavigation()
        
        // Extra
        //let houseCollectionVC = HouseCollectionViewController(model: houses)
        
        //newHouseListViewController.delegate = self
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [houseListNav, seasonListNav]
        tabBarController.delegate = self
        
        splitVC.viewControllers = [tabBarController, houseDetailNavigation, seasonDetailNavigation] as! [UIViewController]
        
        tabBarController.title = "Westeros"
        
        window?.rootViewController = splitVC
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

extension AppDelegate: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // Change detailViewController when user select tab
        // retrieve VC and set as a master
        guard let navigationController = viewController as? UINavigationController,
            let viewController = navigationController.viewControllers.first else {
                return
        }
        
        let detailNav: UINavigationController
        if type(of: viewController) == SeasonListViewController.self {
            detailNav = seasonDetailNavigation
        } else {
            detailNav = houseDetailNavigation
        }
        
        // set correct detailController
        splitVC.showDetailViewController(detailNav, sender: nil)
    }
}
