//
//  Extension + UIViewController.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 27.08.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlertController(
        with title: String,
        and message: String,
        and nameTextField: String,
        and infoTextField: String,
        _ funcActions: @escaping (String, String) -> ()) {
            
            let alert = UIAlertController(title: title, message:
                                            message,
                                          preferredStyle: .alert)
            let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
                guard let nameCustomer = alert.textFields?.first?.text,
                      !nameCustomer.isEmpty else {
                    return
                }
                guard let infoCustomer = alert.textFields?.last?.text,
                      !infoCustomer.isEmpty else {
                    return
                }
                funcActions(nameCustomer, infoCustomer)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
            
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            alert.addTextField { nameTF in
                nameTF.placeholder = "New name"
                nameTF.text = nameTextField
            }
            alert.addTextField { infoTF in
                infoTF.placeholder = "Enter info"
                infoTF.text = infoTextField
            }
            
            present(alert, animated: true)
    }
}
