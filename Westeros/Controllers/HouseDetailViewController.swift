//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by Alexandre on 12/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {
    
    // MARK: - Properties
    var model: House
    
    // MARK: - Outlets
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var wordsLabel: UILabel!
    
    // MARK: - Initialization
    init(model: House) {
        
        self.model = model
        
        super.init(nibName: "HouseDetailViewController", bundle: Bundle.main)
        
        title = model.name
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
        
        syncModelWithView()
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        houseNameLabel.text = "House \(model.name)"
        sigilImageView.image = model.sigil.image
        wordsLabel.text = model.words
        title = model.name
    }
    
    // MARK: - UI
    func setupUI() {
        
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        
        let memberButton = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(displayMembers))
        
        navigationItem.rightBarButtonItems  = [wikiButton, memberButton]
    }
    
    @objc func displayWiki() {
        
        let wikiVC = WikiViewController(model: model)
        
        navigationController?.pushViewController(wikiVC, animated: true)
        
    }
    
    @objc func displayMembers() {
        
        let memberListVC = MemberListViewController(model: model.sortedMembers)
        
        navigationController?.pushViewController(memberListVC, animated: true)
    }
}

extension HouseDetailViewController: HouseListTableViewControllerDelegate {
    func houseListTableViewController(_ vc: HouseListTableViewController, didSelectHouse house: House) {
        self.model = house
        syncModelWithView()
    }
}
