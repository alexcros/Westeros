//
//  MemberListViewController.swift
//  Westeros
//
//  Created by Alexandre on 18/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import UIKit

class MemberListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var model: [Person]
    
    // MARK: - Initialization
    init(model: [Person]) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Members"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Observe houseVC notification changes
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(houseDidChange), name: .houseDidChangeNotification
            , object: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: Notifications
    @objc func houseDidChange(notification: Notification) {
        // get house info
        let info = notification.userInfo!
        
        let house = info[Constants.HouseKey] as? House
        
        let members = house?.sortedMembers
        
        model = members!
        
        syncViewWithModel()
        
    }
    
    // MARK: - Sync
    func syncViewWithModel() {
        //        title = mode
        //title = model.description
        tableView.reloadData()
    }
    
    
}

extension MemberListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "PersonCell"
        
        let person = model[indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = person.name
        cell?.detailTextLabel?.text = person.alias
        
        return cell!
    }
    
}

extension MemberListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = model[indexPath.row]
        
        let memberDetailViewController = MemberDetailViewController(model: person)
        
        navigationController?.pushViewController(memberDetailViewController, animated: true)
    }
}
