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
    var seasonDetailNC: UINavigationController!
    var houseDetailNC: UINavigationController!
    let splitVC = UISplitViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Models
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        //_ = Repository.local.episodes
        
        // NEW INTERFACE
        // Controllers
        // Master
        let houseListVC = HouseListTableViewController(model: houses)
        let lastHouseSelected = houseListVC.lastSelectedHouse() // reset
        let houseDetailViewController = HouseDetailViewController(model: lastHouseSelected)
        
        let seasonListViewController = SeasonListViewController(model: seasons)
        let seasonDetailViewController = SeasonDetailViewController(model: seasons.first!)
        
        // delegates
        if UIDevice.current.userInterfaceIdiom == .pad {
            houseListVC.delegated = houseDetailViewController
            seasonListViewController.delegate = seasonDetailViewController
        } else {
            houseListVC.delegated = houseListVC as? HouseListTableViewControllerDelegate
            seasonListViewController.delegate = seasonListViewController
        }
        
        var houseListNC: UINavigationController!
        var seasonListNC: UINavigationController!
        
        // navigation controllers
        houseListNC = houseListVC.wrappedInNavigation()
        seasonListNC = seasonListViewController.wrappedInNavigation()
        houseDetailNC = houseDetailViewController.wrappedInNavigation()
        seasonDetailNC = seasonDetailViewController.wrappedInNavigation()
        
        // Extra
        //let houseCollectionVC = HouseCollectionViewController(model: houses)
        
        // tabbar
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [houseListNC, seasonListNC]
        tabBarController.delegate = self
        
        splitVC.viewControllers = [tabBarController, houseDetailNC, seasonDetailNC]
        
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
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            // Change detailVC on iPad
            let detailNav: UINavigationController
            if type(of: viewController) == SeasonListViewController.self {
                detailNav = seasonDetailNC
            } else {
                detailNav = houseDetailNC
            }
            
            // set correct detailController
            splitVC.showDetailViewController(detailNav, sender: nil)
        }
        
    }
}
