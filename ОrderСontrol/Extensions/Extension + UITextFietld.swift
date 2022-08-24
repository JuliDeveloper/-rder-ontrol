//
//  Extension + UITextFietld.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 24.08.2022.
//

import UIKit

extension UITextField {
    func config(_ placeholderText: String) {
        textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        placeholder = placeholderText
        layer.cornerRadius = 10
    }
}
