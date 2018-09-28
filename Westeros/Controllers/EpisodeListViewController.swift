//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by Alexandre on 25/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import UIKit

class EpisodeListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var episodeTableView: UITableView!
    
    // MARK: - Properties
    let model: [Episode]
    
    // MARK: - Initialization
    init(model: [Episode]) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Episodes"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        episodeTableView.dataSource = self
        episodeTableView.delegate = self
    }
    
}

extension EpisodeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "EpisodeCell"
        
        let episode = model[indexPath.row]
    
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = "\(episode.name)"
        cell?.detailTextLabel?.text = "\(episode.broadcastDate)"
        
        return cell!
    }
    
}

extension EpisodeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episodes = model[indexPath.row].season?.sortedEpisodes
        
        let episodeDetaiViewController = EpisodeDetailViewController(model: (episodes?.first)!)
        
        navigationController?.pushViewController(episodeDetaiViewController, animated: true)
    }
}
