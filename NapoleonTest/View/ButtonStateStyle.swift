//
//  ButtonStateStyle.swift
//  NapoleonTest
//
//  Created by Роман Тищенко on 16/12/2018.
//  Copyright © 2018 Роман Тищенко. All rights reserved.
//

import UIKit

class ButtonStateStyle {
    
    private init () {}
    
    static func Selected (button: UIButton) {
        button.layer.backgroundColor = #colorLiteral(red: 0.9309856943, green: 0.955286414, blue: 1, alpha: 1)
        button.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), for: .normal)
        button.layer.borderWidth = 1
    }
    
    static func NotSelected (button: UIButton) {
        button.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.borderWidth = 0
        button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
    }
}
