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
        window?.backgroundColor = .cyan
        
        // Model
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons

        // Controllers
        // Master
        let houseListVC = HouseListTableViewController(model: houses)
        let lastHouseSelected = houseListVC.lastSelectedHouse() // reset
       
        // Detail
        let houseDetailVC = HouseDetailViewController(model: lastHouseSelected)
        
        // Assign delegate
        houseListVC.delegate = houseDetailVC
        
        // Combinator for iPad
        let splitVC = UISplitViewController()
        splitVC.viewControllers = [houseListVC.wrappedInNavigation(), houseDetailVC.wrappedInNavigation()]
        
        let houseCollectionVC = HouseCollectionViewController(model: houses)
        
        window?.rootViewController = houseCollectionVC
        window?.makeKeyAndVisible()
        
        return true
    }

}

