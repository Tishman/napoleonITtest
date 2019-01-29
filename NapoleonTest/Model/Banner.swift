//
//  Banner.swift
//  NapoleonTest
//
//  Created by Роман Тищенко on 16/12/2018.
//  Copyright © 2018 Роман Тищенко. All rights reserved.
//

import Foundation

struct Banner: Decodable, ImageEntityProtocol {
    var id: String
    var title: String?
    var desc: String?
    var image: String?
}
