//
//  CustomerDetails.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 24.08.2022.
//

import UIKit

class CustomerDetails: UIViewController {
    
    private let nameLable: UILabel = {
        let lable = UILabel()
        lable.config("Name")
        return lable
    }()
    
    private let infoLable: UILabel = {
        let lable = UILabel()
        lable.config("Info")
        return lable
    }()
    
    private let nameTextField: UITextField = {
        let tf = UITextField()
        tf.config("Name")
        return tf
    }()
    
    private let infoTextField: UITextField = {
        let tf = UITextField()
        tf.config("Info")
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        setUpNavigationBar()
        setUpStacks()
    }
}

//MARK: - Private func
extension CustomerDetails {
    private func setUpNavigationBar() {
        title = "Customer"
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save,
                                         target: self,
                                         action: #selector(saveCustomer))
        navigationItem.rightBarButtonItem = saveButton
        saveButton.tintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                           target: self,
                                           action: #selector(cancel))
        navigationItem.leftBarButtonItem = cancelButton
        cancelButton.tintColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
    }
    
    private func setUpStacks() {
        let nameStack = UIStackView(arrangedSubviews: [nameLable, infoLable])
        let infoStack = UIStackView(arrangedSubviews: [nameTextField, infoTextField])
        
        nameStack.config()
        infoStack.config()
        
        let stack = UIStackView(arrangedSubviews: [nameStack, infoStack])
        stack.config()
        stack.axis = .horizontal
        view.addSubview(stack)
        setUpConstraint(for: stack)
    }

    private func setUpConstraint(for stack: UIStackView) {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func saveCustomer() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func cancel() {
        navigationController?.popViewController(animated: true)
    }
}
