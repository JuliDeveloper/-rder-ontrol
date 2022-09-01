//
//  Extension + UIButton.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 24.08.2022.
//

import UIKit

extension UIButton {
    func config(_ title: String, _ image: String) {
        setTitle(title, for: .normal)
        setImage(UIImage(systemName: image), for: .normal)
        backgroundColor = Color.orangeColor
        tintColor = Color.whiteColor
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        layer.cornerRadius = Constant.radius
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
