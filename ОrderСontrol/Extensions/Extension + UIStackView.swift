//
//  Extension + UIStackView.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 25.08.2022.
//

import Foundation
import UIKit

extension UIStackView {
    func config() {
        axis = .vertical
        alignment = .fill
        distribution = .fill
        spacing = 8
        translatesAutoresizingMaskIntoConstraints = false
    }
}
