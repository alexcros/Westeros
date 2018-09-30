//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Alexandre on 25/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var broadcastLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    
    // MARK: - Properties
    var model: Episode
    
    // MARK: - Initialization
    init(model: Episode) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Episode Info"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        syncModelWithView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Observe season notification changes
        NotificationCenter.default.addObserver(self, selector: #selector(seasonDidChange), name: .seasonDidChangeNotification, object: nil)
    }
    
    // MARK: Notifications
    @objc func seasonDidChange(notification: Notification) {
        
        // get season info
        let info = notification.userInfo!
        
        let season = info[Constants.SeasonKey] as? Season
        
        let episodes = season?.sortedEpisodes
        
        model = (episodes?.first)!
        syncModelWithView()
        
    }
    
    // MARK: - Syncro
    func syncModelWithView() {
        nameLabel.text = model.name
        broadcastLabel.text = "\(model.broadcastDate)"
        detailLabel.text = model.description
    }

}
