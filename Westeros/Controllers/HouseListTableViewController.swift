//
//  HouseListTableViewController.swift
//  Westeros
//
//  Created by Alexandre on 17/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import UIKit
// class: guarantee that this protocol will be used only on classes and no other stuff like enums or structs.
protocol HouseListTableViewControllerDelegate: class {
    
    func houseListTableViewController(_ vc: HouseListTableViewController, didSelectHouse house: House)
    
}

class HouseListTableViewController: UITableViewController {
    
    // MARK: - Properties
    let model: [House]
    weak var delegated: HouseListTableViewControllerDelegate?
    
    // MARK: - Initialization
    init(model: [House]) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Westeros"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCustomCell()
    }
    
    func registerCustomCell() {
        let nib = UINib(nibName: "HouseCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HouseCell")
    }
    
    // MARK: - Table view DATASOURCE
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "HouseCell"
        
        let house = model[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! HouseCell
        
        cell.sigilImageView.image = house.sigil.image
        cell.nameLabel.text = house.name
        cell.wordsLabel.text = house.words
        
        return cell
        
    }
    
    // MARK: - Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let house = model[indexPath.row]
        
        // notify to delegate the change
        delegated?.houseListTableViewController(self, didSelectHouse: house)
        
        // Send notification
        let nc = NotificationCenter.default

        let notification = Notification(name: Notification.Name(Constants.HouseDidChangeNotificationName), object: self, userInfo: [Constants.HouseKey: house])
        
        nc.post(notification)
        
        // Save last selected index
        saveLastSelectedHouse(at: indexPath.row)
        
    }
    
}

// Mark: - HouseListTableViewControllerDelegate
extension HouseListTableViewController: HouseListTableViewControllerDelegate {
    func houseListTableViewController(_ vc: HouseListTableViewController, didSelectHouse house: House) {
        let houseDetailViewController = HouseDetailViewController(model: house)
        navigationController?.pushViewController(houseDetailViewController, animated: true)
    }
}


// MARK: - Persistence (UserDefaults)
extension HouseListTableViewController {
    func saveLastSelectedHouse(at row: Int) {
        
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(row, forKey: Constants.lastHouseKey)
        
        userDefaults.synchronize()
    }
    
    func lastSelectedHouse() -> House {
        
        let index =  UserDefaults.standard.integer(forKey: Constants.lastHouseKey)
        
        return house(at: index)
    }
    
    func house(at index: Int) -> House {
        return model[index]
    }
    
}
