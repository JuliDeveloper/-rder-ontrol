//
//  DetailsRowViewController.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 08.09.2022.
//

import UIKit

class DetailsRowViewController: UIViewController {
    
    var row: RowOfOrder?
    var delegate: RowsViewControllerDelegate?
    
    private let serviceLabel = CustomLabel(text: "Service:")
    private let priceLabel = CustomLabel(text: "Price:")
    
    private let serviceTextField: UITextField = {
        let tf = UITextField()
        let spacer = UIView()
        spacer.frame = CGRect(x: 0, y: 0, width: 12, height: 31)
        tf.leftView = spacer
        tf.leftViewMode = .always
        tf.backgroundColor = Color.whiteColor
        tf.layer.borderColor = Color.orangeColor.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = Constant.radius
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.heightAnchor.constraint(equalToConstant: 31).isActive = true
        return tf
    }()
    let priceTextField: UITextField = {
        let tf = UITextField()
        let spacer = UIView()
        spacer.frame = CGRect(x: 0, y: 0, width: 12, height: 31)
        tf.leftView = spacer
        tf.leftViewMode = .always
        tf.backgroundColor = Color.whiteColor
        tf.layer.borderColor = Color.orangeColor.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = Constant.radius
        tf.keyboardType = .decimalPad
        tf.placeholder = "0.0"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.heightAnchor.constraint(equalToConstant: 31).isActive = true
        return tf
    }()
    private lazy var selectServiceButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25)
        let image = UIImage(systemName: "arrowshape.turn.up.right.circle.fill",
                            withConfiguration: largeConfig)
        button.setImage(image, for: .normal)
        button.backgroundColor = Color.whiteColor
        button.tintColor = Color.orangeColor
        button.addTarget(self,
                         action: #selector(selectService),
                         for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30 / 2
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add row"
        view.backgroundColor = Color.backgroundColor
        
        setUpButtons()
        configGeneralStack()
    }
}

// MARK: - Private functions
extension DetailsRowViewController {
    private func setUpButtons() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                           target: self,
                                           action: #selector(cancel))
        cancelButton.tintColor = Color.orangeColor
        navigationItem.leftBarButtonItem = cancelButton
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save,
                                         target: self,
                                         action: #selector(save))
        saveButton.tintColor = Color.orangeColor
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func save() {
        
        
        
        delegate?.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configServiceStack() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [serviceLabel,
                                                   serviceTextField,
                                                   selectServiceButton])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 10
        
        return stack
    }
    
    private func configPriceStack() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [priceLabel,
                                                   priceTextField])
        
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 10
        
        return stack
    }
    
    private func configGeneralStack() {
        let serviceStack = configServiceStack()
        let priceStack = configPriceStack()
        
        let stack = UIStackView(arrangedSubviews: [serviceStack,
                                                   priceStack])
        
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        setupConstraints(for: stack)
    }
    
    private func setupConstraints(for stack: UIStackView) {
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func selectService() {
        let servicesVC = ServicesTableViewController()
        navigationController?.pushViewController(servicesVC, animated: true)
        servicesVC.didSelectedService = { [unowned self] service in
            self.row?.service = service
            self.serviceTextField.text = service.name
            servicesVC.services.append(service)
            servicesVC.tableView.reloadData()
        }
    }
}
