//
//  CustomLabel.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 01.09.2022.
//

import UIKit

class CustomLabel: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        
        self.text = text
        tintColor = Color.blackColor
        font = .systemFont(ofSize: 17)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
