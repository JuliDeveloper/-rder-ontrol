//
//  DetailsDocumentViewController.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 29.08.2022.
//

import UIKit

class DetailsDocumentsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        
        setUpButtons()
    }
    
}

// MARK: - Private funcs
extension DetailsDocumentsViewController {
    private func setUpButtons() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        cancelButton.tintColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        navigationItem.leftBarButtonItem = cancelButton
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        saveButton.tintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func save() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func cancel() {
        navigationController?.popViewController(animated: true)
    }
}
