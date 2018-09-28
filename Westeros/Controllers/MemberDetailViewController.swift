//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by Alexandre on 26/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var memberNameLabel: UILabel!
    
    @IBOutlet var memberAliasLabel: UILabel!
    
    // MARK: - Properties
    var model: Person!
    
    // MARK: - Initialization
    init(model: Person) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
        
        title = model.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        syncViewWithModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Observe season notification changes
        NotificationCenter.default.addObserver(self, selector: #selector(houseDidChange), name: .houseDidChangeNotification, object: nil)
    }

    // MARK: - Sync
    func syncViewWithModel() {
        memberNameLabel.text = model.fullName
        memberAliasLabel.text = model.alias
    }

    // MARK: Notifications
    @objc func houseDidChange(notification: Notification) {
        
        // get house info
        let info = notification.userInfo!
        
        let house = info[Constants.HouseKey] as? House
        
        model = house?.sortedMembers.first
        syncViewWithModel()
        
    }

}
