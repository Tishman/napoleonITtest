//
//  BannerCollectionCell.swift
//  NapoleonTest
//
//  Created by Роман Тищенко on 16/12/2018.
//  Copyright © 2018 Роман Тищенко. All rights reserved.
//

import UIKit

class BannerCollectionCell: UICollectionViewCell {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet weak var blurEffect: UIVisualEffectView!
    @IBOutlet weak var contentDescription: UILabel!
    @IBOutlet weak var title: UILabel!
    
    func setUpStyleForCell () {
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        
        let shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: -3, height: 5)
        self.layer.shadowPath = shadowPath
    }
    
    func updateCell (banner: Banner, bannerImage: UIImage) {
        if banner.title == nil && banner.desc == nil {
            self.blurEffect.alpha = 0
            self.title.isHidden = true
            self.contentDescription.isHidden = true
            self.image.image = bannerImage
        } else {
            let tempString = banner.desc
            let bannerString = tempString?.capitalizingFirstLetter()
            self.blurEffect.alpha = 0.8
            self.title.isHidden = false
            self.contentDescription.isHidden = false
            self.title.text = banner.title            
            self.contentDescription.text = bannerString
            self.image.image = bannerImage
        }
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
