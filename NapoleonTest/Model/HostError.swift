//
//  HostError.swift
//  NapoleonTest
//
//  Created by Роман Тищенко on 16/12/2018.
//  Copyright © 2018 Роман Тищенко. All rights reserved.
//

import Foundation

struct HostError: Decodable {
    var message: String
    var code: Int
}
