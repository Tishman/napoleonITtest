//
//  BannerCell.swift
//  NapoleonTest
//
//  Created by Роман Тищенко on 15/12/2018.
//  Copyright © 2018 Роман Тищенко. All rights reserved.
//

import UIKit

class BannerTableCell: UITableViewCell, UIScrollViewDelegate {
    
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!

    func setUpStyleForCell() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 250, height: 160)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 10
        
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.isPagingEnabled = true
        collectionView.alwaysBounceVertical = false
    }
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDelegate & UICollectionViewDataSource>
        (_ dataSourceDelegate: D, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        
        collectionView.reloadData()
    }
}
