//
//  Extension + UITextFietld.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 24.08.2022.
//

import UIKit

extension UITextField {
    func config(_ placeholderText: String) {
        let spacer = UIView()
        spacer.frame = CGRect(x: 0, y: 0, width: 12, height: 31)
        leftView = spacer
        leftViewMode = .always
        textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        placeholder = placeholderText
        layer.cornerRadius = 8
        layer.borderColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        layer.borderWidth = 1
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 31).isActive = true
    }
}
