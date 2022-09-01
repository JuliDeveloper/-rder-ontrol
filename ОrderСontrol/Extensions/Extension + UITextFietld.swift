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
        textColor = Color.blackColor
        placeholder = placeholderText
        layer.cornerRadius = Constant.radius
        layer.borderColor = Color.orangeColor.cgColor
        layer.borderWidth = 1
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 31).isActive = true
    }
}
