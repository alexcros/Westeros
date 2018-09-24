//
//  HouseCell.swift
//  Westeros
//
//  Created by Alexandre on 19/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import UIKit

class HouseCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: self) 

    // MARK: - Outlets
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var wordsLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        sigilImageView.image = nil
        nameLabel.text = nil
        wordsLabel.text = nil
        
    }
}
