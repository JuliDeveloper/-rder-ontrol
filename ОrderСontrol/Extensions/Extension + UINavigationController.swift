//
//  Extension + UINavigationController.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 01.09.2022.
//

import UIKit

extension UINavigationController {
    func setUpBackButtons() {
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        backButton.tintColor = Color.orangeColor
        navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    
}
