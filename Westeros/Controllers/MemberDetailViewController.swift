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
    let model: Person!
    
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

    // MARK: - Sync
    func syncViewWithModel() {
        memberNameLabel.text = model.fullName
        memberAliasLabel.text = model.alias
    }



}
