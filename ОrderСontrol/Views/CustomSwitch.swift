//
//  CustomSwitch.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 01.09.2022.
//

import UIKit

class CustomSwitch: UISwitch {
    init() {
        super.init(frame: .zero)
        
        onTintColor = Color.orangeColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
