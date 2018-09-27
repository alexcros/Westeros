//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by Alexandre on 25/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import UIKit

protocol SeasonListViewControllerDelegate {
    
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season)
    
}

class SeasonListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var seasonTableView: UITableView!
    
    // MARK: - Properties
    let model: [Season]
    var delegate: SeasonListViewControllerDelegate?
    
    // MARK: - Initialization
    init(model: [Season]) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Seasons"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seasonTableView.dataSource = self
        seasonTableView.delegate = self
    }
    
}

extension SeasonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "SeasonCell"
        
        let season = model[indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = season.name
        cell?.detailTextLabel?.text = "\(season.releaseDate)"
        
        return cell!
    }
    
}

extension SeasonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let season = model[indexPath.row]
        
        delegate?.seasonListViewController(self, didSelectSeason: season)
        
        let nc = NotificationCenter.default
        // TODO:
        let notification = Notification(name: Notification.Name(Constants.SeasonDidChangeNotificationName),
                                        object: self,
                                        userInfo: [Constants.SeasonKey : season])
        
        nc.post(notification)
        
    }
}

// MARK: - SeasonListViewControllerDelegate
extension SeasonListViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season) {
        let seasonDetailViewController = SeasonDetailViewController(model: season)
        navigationController?.pushViewController(seasonDetailViewController, animated: true)
    }
}
