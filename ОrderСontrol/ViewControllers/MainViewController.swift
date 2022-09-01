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
        button.config("Customer", "person.fill")
        button.addTarget(self,
                         action: #selector(openCustomerController),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var serviseButton: UIButton = {
        let button = UIButton(type: .system)
        button.config("Servise", "tray.full.fill")
        button.addTarget(self,
                         action: #selector(openServiceController),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var documentsButton: UIButton = {
        let button = UIButton(type: .system)
        button.config("Documents", "folder.fill")
        button.addTarget(self,
                         action: #selector(openDocumentsController),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var ordersReportButton: UIButton = {
        let button = UIButton(type: .system)
        button.config("Orders report", "list.bullet.below.rectangle")
        button.addTarget(self,
                         action: #selector(openOrdersReportController),
                         for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.backgroundColor
        setUpStack()
    }
}

//MARK: - Private func
extension MainViewController {
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
            stack.topAnchor.constraint(equalTo: view.topAnchor,
                                       constant: view.bounds.height / 3),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                            constant: -20)
        ])
    }
    
    @objc private func openCustomerController() {
        let customerVC = CustomersTableViewController()
        navigationController?.pushViewController(customerVC, animated: true)
    }
    
    @objc private func openServiceController() {
        let serviceVC = ServicesTableViewController()
        navigationController?.pushViewController(serviceVC, animated: true)
    }

    @objc private func openDocumentsController() {
        let docementsVC = DocumentsTableViewController()
        navigationController?.pushViewController(docementsVC, animated: true)
    }

    @objc private func openOrdersReportController() {}
}
