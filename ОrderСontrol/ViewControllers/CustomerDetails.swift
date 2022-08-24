//
//  CustomerDetails.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 24.08.2022.
//

import UIKit

class CustomerDetails: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        setUpNavigationBar()
    }
    
    private func setUpNavigationBar() {
        title = "Customer"
        navigationController?.navigationBar.prefersLargeTitles = true
            
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveCustomer)
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
    }
    
    @objc private func saveCustomer() {
        
    }
    
    @objc private func cancel() {
        navigationController?.popViewController(animated: true)
    }
}
