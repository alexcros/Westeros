//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by Alexandre on 25/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var broadcastLabel: UILabel!
    @IBOutlet var episodesTableView: UITableView!
    @IBOutlet var button: UIButton!
    
    // MARK: - Properties
    var model: Season
    
    // MARK: - Initialization
    init(model: Season) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Season"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        episodesTableView.dataSource = self
        episodesTableView.delegate = self
        
        syncModelWithView()
    }

    // MARK: - Sync
    func syncModelWithView() {
        title = model.name
        nameLabel.text = model.name
        broadcastLabel.text = "\(model.releaseDate)"
    }
    
    // MARK: - IBActions
    @IBAction func episodesListButton(_ sender: UIButton) {
        let episodeListViewController = EpisodeListViewController(model: model.sortedEpisodes)
        navigationController?.pushViewController(episodeListViewController, animated: true)
    }
    
}

// MARK: - UITableViewDataSource
extension SeasonDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Episodes"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.sortedEpisodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "EpisodeCell"
        
        let episode = model.sortedEpisodes[indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = episode.name
        cell?.detailTextLabel?.text = "\(episode.broadcastDate)"
        
        
        return cell!
    }
    
}

// MARK: - UITableViewDelegate
extension SeasonDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = model.sortedEpisodes[indexPath.row]
        
        let episodeDetailViewController = EpisodeDetailViewController(model: episode)
        
        navigationController?.pushViewController(episodeDetailViewController, animated: true)
    }
    
}

// MARK: - SeasonListViewControllerDelegate
extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season) {
        model = season
        syncModelWithView()
    }
}
