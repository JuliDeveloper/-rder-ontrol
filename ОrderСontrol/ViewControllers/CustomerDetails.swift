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
        setUpVerticalStack()
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
    
    private func setUpStack(with lables: [UILabel]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: lables)
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }
    
    private func setUpStack(with textFieldss: [UITextField]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: textFieldss)
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }
    
    private func setUpVerticalStack() {
        let nameStack: UIStackView = setUpStack(with: [nameLable, infoLable])
        let infoStack: UIStackView = setUpStack(with: [nameTextField, infoTextField])

        let stack = UIStackView(arrangedSubviews: [nameStack, infoStack])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        view.addSubview(stack)
        setUpConstraint(for: stack)
    }
    
    private func setUpConstraint(for stack: UIStackView) {
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func saveCustomer() {
        
    }
    
    @objc private func cancel() {
        navigationController?.popViewController(animated: true)
    }
}
