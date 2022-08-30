//
//  CustomerTableViewController.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 24.08.2022.
//

import UIKit

private let reuseIdentifier = "cell"

class CustomersTableViewController: UITableViewController {
    
    typealias Select = (Customer?) -> ()
    var didSelect: Select?
    
    private let context = StorageManager.shared.context
    private var customers: [Customer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Customers"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        
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
            showAlertController(with: "Edit Customer",
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
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        backButton.tintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCustomer))
        addButton.tintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
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
        showAlertController(with: "New Customer",
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
        
        StorageManager.shared.saveContext()
    }
    
    private func editCustomer(_ newName: String, _ newInfo: String) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        customers[indexPath.row].name = newName
        customers[indexPath.row].info = newInfo
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        StorageManager.shared.saveContext()
    }
}
