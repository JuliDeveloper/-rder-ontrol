//
//  CustomerTableViewController.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 24.08.2022.
//

import UIKit

private let reuseIdentifier = "cell"

class CustomersTableViewController: UITableViewController {
    
    typealias Select = (Customer) -> ()
    var didSelect: Select?
    
    private let context = StorageManager.shared.context
    private var customers: [Customer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Customers"
        
        tableView.config()
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: reuseIdentifier)
        
        setUpButtons()
        fetchData()
        tableView.reloadData()
    }
}

//MARK: - Table view Data source
extension CustomersTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        customers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let customer = customers[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = customer.name
        content.secondaryText = customer.info
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        let customer = customers[indexPath.row]
        
        if editingStyle == .delete {
            customers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageManager.shared.deleteObject(object: customer)
        }
    }
}

//MARK: - Table View Delegate
extension CustomersTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let customer = customers[indexPath.row]
        
        if let didSelect = self.didSelect {
            didSelect(customer)
            navigationController?.popViewController(animated: true)
        } else {
            showAlertControllerForEdit(with: "Edit Customer",
                                and: "Change name or info",
                                and: customer.name ?? "",
                                and: customer.info ?? "",
                                editCustomer)
        }
    }
}

//MARK: - Private func
extension CustomersTableViewController {
    private func setUpButtons() {
        navigationController?.setUpBackButtons()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(addNewCustomer))
        addButton.tintColor = Color.orangeColor
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func fetchData() {
        StorageManager.shared.fetchCustomer { result in
            switch result {
            case .success(let customers):
                self.customers = customers
            case .failure(let error):
                print(error)
            }
        }
    }

    @objc private func addNewCustomer() {
        showAlertControllerForNew(with: "New Customer",
                            and: "Add name and info",
                            and: "",
                            and: "",
                            saveNewCustomer)
    }
    
    private func saveNewCustomer(_ nameCustomer: String, _ infoCustomer: String) {
        let customer = Customer(context: context)
        
        customer.name = nameCustomer
        customer.info = infoCustomer
        
        customers.append(customer)
        
        let cellIndex = IndexPath(row: customers.count - 1, section: 0)
        tableView.insertRows(at: [cellIndex], with: .automatic)
    }
    
    private func editCustomer(_ newName: String, _ newInfo: String) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        customers[indexPath.row].name = newName
        customers[indexPath.row].info = newInfo
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        StorageManager.shared.saveContext()
    }
}
