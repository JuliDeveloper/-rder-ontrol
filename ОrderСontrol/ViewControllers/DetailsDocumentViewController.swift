//
//  DetailsDocumentViewController.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 29.08.2022.
//

import UIKit
import CoreData

class DetailsDocumentsViewController: UIViewController {
    
    private let context = StorageManager.shared.context
    
    var order: Order?
    var delegate: DocumentViewControllerDelegate?

  
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.date = .now
        picker.backgroundColor = .white
        picker.layer.borderWidth = 1
        picker.layer.borderColor = Color.orangeColor.cgColor
        picker.layer.masksToBounds = true
        picker.layer.cornerRadius = Constant.radius
        return picker
    }()
    
    let customerLabel = CustomLabel(text: "Customer")
    let madeLabel = CustomLabel(text: "Made")
    let paidLabel = CustomLabel(text: "Paid")
    let rowsLabel = CustomLabel(text: "Rows of order")
    
    let customerTextField: UITextField = {
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
    
    let switcherMade = CustomSwitch()
    let switcherPaid = CustomSwitch()
    
    lazy var selectCustomerButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25)
        let image = UIImage(systemName: "arrowshape.turn.up.right.circle.fill",
                            withConfiguration: largeConfig)
        button.setImage(image, for: .normal)
        button.backgroundColor = Color.whiteColor
        button.tintColor = Color.orangeColor
        button.addTarget(self,
                         action: #selector(selectCustomer),
                         for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30 / 2
        return button
    }()
    
    private let serviceTable: RowOfOrderViewController = {
        let table = RowOfOrderViewController()
        table.refreshControl?.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var rowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Row", for: .normal)
        button.backgroundColor = Color.orangeColor
        button.tintColor = Color.whiteColor
        button.layer.cornerRadius = Constant.radius
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Order"
        view.backgroundColor = Color.backgroundColor
        
        customerTextField.delegate = self
        
        setUpButtons()
        configStackView()
    }
}

// MARK: - Private funcs
extension DetailsDocumentsViewController {
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
        
        if order == nil {
            StorageManager.shared.addDocument(customerName: customerTextField.text ?? "",
                                              made: switcherMade.isOn,
                                              paid: switcherPaid.isOn,
                                              datePicker: datePicker)
        } else {
            StorageManager.shared.editDocument(document: order ?? Order(),
                                               newCustomerName: customerTextField.text ?? "",
                                               newMade: switcherMade.isOn,
                                               newPaid: switcherPaid.isOn)
        }
        delegate?.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configStackView() {
        let stackCustomer = configStackCustomer()
        let madeStack = configStackMade()
        let paidStack = configStackPaid()
        let rowsStack = configStackRows()
        
        let stack = UIStackView(arrangedSubviews: [datePicker, stackCustomer,
                                                   madeStack, paidStack,
                                                   rowsStack])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 10
        
        view.addSubview(stack)
        
        configConstraints(for: stack)
    }
    
    private func configConstraints(for stack: UIStackView) {
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: 20),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                       constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                            constant: -20)
        ])
    }
    
    private func configStackCustomer() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [customerLabel, customerTextField, selectCustomerButton])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }
    
    private func configStackMade() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [madeLabel, switcherMade])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }
    
    private func configStackPaid() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [paidLabel, switcherPaid])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }
    
    private func configStackRows() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [rowsLabel, rowButton])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }
    
    @objc private func selectCustomer() {
        let customersVC = CustomersTableViewController()
        navigationController?.pushViewController(customersVC, animated: true)
        customersVC.didSelect = { [unowned self] customer in
            self.order?.customer = customer
            self.customerTextField.text = customer.name
        }
    }
}

extension DetailsDocumentsViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
