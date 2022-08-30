//
//  DetailsDocumentViewController.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 29.08.2022.
//

import UIKit

class DetailsDocumentsViewController: UIViewController {
    
    //private let context = StorageManager.shared.context
    var order: Order!
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.date = .now
        picker.backgroundColor = .white
        picker.layer.borderWidth = 1
        picker.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        picker.layer.masksToBounds = true
        picker.layer.cornerRadius = 10
        return picker
    }()
    let customerLable: UILabel = {
        let lable = UILabel()
        lable.text = "Customer"
        lable.font = .systemFont(ofSize: 17)
        lable.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return lable
    }()
    let madeLable: UILabel = {
        let lable = UILabel()
        lable.text = "Made"
        lable.font = .systemFont(ofSize: 17)
        lable.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return lable
    }()
    let paidLable: UILabel = {
        let lable = UILabel()
        lable.text = "Paid"
        lable.font = .systemFont(ofSize: 17)
        lable.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return lable
    }()
    let customerTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tf.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.heightAnchor.constraint(equalToConstant: 31).isActive = true
        return tf
    }()
    lazy var selectCustomerButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25)
        let image = UIImage(systemName: "arrowshape.turn.up.right.circle.fill",
                            withConfiguration: largeConfig)
        button.setImage(image, for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        button.addTarget(self, action: #selector(selectCustomer), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30 / 2
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Order"
        view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        
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
        cancelButton.tintColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        navigationItem.leftBarButtonItem = cancelButton
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save,
                                         target: self,
                                         action: #selector(save))
        saveButton.tintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func save() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configStackView() {
        let stackCustomer = configStackCustomer()
        let madeStack = configStackMade()
        let paidStack = configStackPaid()
        
        let stack = UIStackView(arrangedSubviews: [datePicker, stackCustomer,
                                                   madeStack, paidStack])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 20
        
        view.addSubview(stack)
        
        configConstraints(for: stack)
    }
    
    private func configConstraints(for stack: UIStackView) {
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func configStackCustomer() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [customerLable, customerTextField, selectCustomerButton])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }
    
    private func configStackMade() -> UIStackView {
        let switcher = UISwitch()
        switcher.onTintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        let stack = UIStackView(arrangedSubviews: [madeLable, switcher])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }
    
    private func configStackPaid() -> UIStackView {
        let switcher = UISwitch()
        switcher.onTintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        let stack = UIStackView(arrangedSubviews: [paidLable, switcher])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }
    
    @objc private func selectCustomer() {
        let customersVC = CustomersTableViewController()
        navigationController?.pushViewController(customersVC, animated: true)
        
    }
}
