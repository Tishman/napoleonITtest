//
//  Offer.swift
//  NapoleonTest
//
//  Created by Роман Тищенко on 16/12/2018.
//  Copyright © 2018 Роман Тищенко. All rights reserved.
//

import Foundation

struct Offer: Decodable, ImageEntityProtocol {
    var name: String?
    var desc: String?
    var groupName: String
    var type: String
    var image: String?
    var price: Double?
    var discount: Double?
}
