//
//  ViewController.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 23.08.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    private lazy var customerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Customer", for: .normal)
        button.setImage(UIImage(systemName: "person.fill"), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(openCustomerController), for: .touchUpInside)
        return button
    }()
    
    private lazy var serviseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Servise", for: .normal)
        button.setImage(UIImage(systemName: "tray.full.fill"), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(openServiceController), for: .touchUpInside)
        return button
    }()
    
    private lazy var documentsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Documents", for: .normal)
        button.setImage(UIImage(systemName: "folder.fill"), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(openDocumentsController), for: .touchUpInside)
        return button
    }()
    
    private lazy var ordersReportButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Orders report", for: .normal)
        button.setImage(UIImage(systemName: "list.bullet.below.rectangle"), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(openOrdersReportController), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        setUpStack()
    }
    
    private func setUpStack() {
        let stack = UIStackView(arrangedSubviews: [customerButton,
                                                   serviseButton,
                                                   documentsButton,
                                                   ordersReportButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        view.addSubview(stack)
        setUpConstraints(for: stack)
    }
    
    private func setUpConstraints(for stack: UIStackView) {
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height / 3),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        customerButton.translatesAutoresizingMaskIntoConstraints = false
        customerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        serviseButton.translatesAutoresizingMaskIntoConstraints = false
        serviseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        documentsButton.translatesAutoresizingMaskIntoConstraints = false
        documentsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        ordersReportButton.translatesAutoresizingMaskIntoConstraints = false
        ordersReportButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc private func openCustomerController() {}
    
    @objc private func openServiceController() {}

    @objc private func openDocumentsController() {}

    @objc private func openOrdersReportController() {}
}

