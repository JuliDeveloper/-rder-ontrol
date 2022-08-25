//
//  Extensin + UILable.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 24.08.2022.
//

import UIKit

extension UILabel {
    func config(_ title: String) {
        text = title
        tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        font = UIFont.systemFont(ofSize: 17)
    }
}
