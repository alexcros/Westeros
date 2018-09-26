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
        //        let lastHouseSelected = houseListVC.lastSelectedHouse() // reset
        let seasonListViewController = SeasonListViewController(model: seasons).wrappedInNavigation()
        //
        //        let episodeListViewController = EpisodeListViewController(model: episodes).wrappedInNavigation()
        //
        // Detail
        //let houseDetailVC = HouseDetailViewController(model: lastHouseSelected)
        //
        //        // Assign delegate
        //        houseListVC.delegate = houseDetailVC
        //
        //        // Combinator for iPad
        //        let splitVC = UISplitViewController()
        //        splitVC.viewControllers = [houseListVC.wrappedInNavigation(), houseDetailVC.wrappedInNavigation() ]
        
        // Extra
        //let houseCollectionVC = HouseCollectionViewController(model: houses)
        
        // NUEVA INTERFAZ GRAFICA
        /*
         Crea un HouseListViewController empaquetado dentro de un UINavigationController.
         Crea un SeasonListViewController empaquetado dentro de un UINavigationViewController Mete a ambos dentro de un UITabBarController
         Usa éste como masterViewController del UISplitViewController. Asegúrate de poder cambiar de uno a otro y poder navegar de House a Person y de Season a Episode.
         */
        
        let newHouseListViewController = HouseListTableViewController(model: houses).wrappedInNavigation()
        let newSeasonListViewController = SeasonListViewController(model: seasons).wrappedInNavigation()
        let tabBarController = UITabBarController()
        
        let seasonDetailViewController = SeasonDetailViewController(model: seasons.first!)
        let houseDetailViewController = HouseDetailViewController(model: houses.first!)
        
        //let lastHouseSelected = newHouseListViewController.lastSelectedHouse() // reset
        
        tabBarController.viewControllers = [newHouseListViewController, newSeasonListViewController]
        //tabBarController.delegate = self
        //
        //        // Combinator for iPad
        let splitVC = UISplitViewController()
        splitVC.viewControllers = [tabBarController, houseDetailViewController.wrappedInNavigation(), seasonDetailViewController.wrappedInNavigation() ] as! [UIViewController]
        
        window?.rootViewController = splitVC
        window?.makeKeyAndVisible()
        
        return true
    }
    
}
