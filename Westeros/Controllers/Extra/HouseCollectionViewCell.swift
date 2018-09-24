//
//  HouseCollectionViewCell.swift
//  Westeros
//
//  Created by Alexandre on 19/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import UIKit

class HouseCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: self)
    
    // MARK: - outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

}
