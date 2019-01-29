//
//  OfferCell.swift
//  NapoleonTest
//
//  Created by Роман Тищенко on 15/12/2018.
//  Copyright © 2018 Роман Тищенко. All rights reserved.
//

import UIKit

class OfferTableCell: UITableViewCell {
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var discountPrice: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var contentDescription: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet var offerImage: UIImageView!
    
    func updateCell (offer: Offer, offerImage: UIImage) {
        if offer.type == "product" {
            self.discount.isHidden = false
            self.discountPrice.isHidden = false
            self.price.isHidden = false
            
            let discountPrice = String(Int(offer.price! - (offer.price! * offer.discount!))) + " ₽"
            let attributePriceString: NSMutableAttributedString =  NSMutableAttributedString(string: String(Int(offer.price!))+" ₽")
            
            attributePriceString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributePriceString.length))
            
            self.price.attributedText = attributePriceString
            self.discountPrice.text = discountPrice
            self.discount.text = "-" + String(Int(offer.discount! * 100)) + "%"
            self.offerImage.image = offerImage
            self.title.text = offer.name
            self.contentDescription.text = offer.desc
        } else {
        self.discount.isHidden = true
        self.discountPrice.isHidden = true
        self.price.isHidden = true
        self.offerImage.image = offerImage
        self.title.text = offer.name
            self.contentDescription.text = offer.desc
        }
    }
    
    func setUpStyleForCell () {
        self.discount.layer.cornerRadius = 8
        self.discount.layer.masksToBounds = true
        self.offerImage.layer.cornerRadius = 8
        self.offerImage.layer.masksToBounds = true
    }
}
