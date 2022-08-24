//
//  Extension + UIButton.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 24.08.2022.
//

import Foundation
import UIKit

extension UIButton {
    func config(_ title: String, _ image: String) {
        setTitle(title, for: .normal)
        setImage(UIImage(systemName: image), for: .normal)
        backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
