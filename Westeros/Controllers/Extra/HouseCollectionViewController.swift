//
//  HouseCollectionViewController.swift
//  Westeros
//
//  Created by Alexandre on 19/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import UIKit

class HouseCollectionViewController: UIViewController {
    
    enum Constants {
        static let columns: CGFloat = 3
    }
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let nib = UINib(nibName: "HouseCollectionViewCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: HouseCollectionViewCell.reuseIdentifier)
        }
    }
    
    // MARK: - Properties
    let model: [House]
    let collectionViewLayout: UICollectionViewFlowLayout
    
    // MARK: - Initialization
    init(model: [House], layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()) { // default layout
        self.model = model
        self.collectionViewLayout = layout
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - UI
    func setupUI() {
        // set datasource
        collectionView.dataSource = self
        
        // setup layout
        let width = calculateItemWidth()
        collectionViewLayout.itemSize = CGSize(width: width, height: width)
        collectionView.collectionViewLayout = collectionViewLayout
    }
    
    func calculateItemWidth() -> CGFloat {
        let viewWidth = view.frame.width
        let spacing = (Constants.columns - 1) *
            collectionViewLayout.minimumInteritemSpacing
        let width = (viewWidth - spacing) / Constants.columns
        
        return width
        
    }
    
}

extension HouseCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let house = model[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HouseCollectionViewCell.reuseIdentifier, for: indexPath) as! HouseCollectionViewCell
        
        cell.imageView.image = house.sigil.image
        cell.nameLabel.text = house.name
        
        return cell
    }

}
