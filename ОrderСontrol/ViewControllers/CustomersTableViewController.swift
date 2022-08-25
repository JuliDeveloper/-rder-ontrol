//
//  CustomerTableViewController.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 24.08.2022.
//

import UIKit

private let reuseIdentifier = "cell"

class CustomersTableViewController: UITableViewController {
    
    private var customers: [Customer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Customers"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        
        setUpButton()
        fetchData()
        tableView.reloadData()
    }
}

//MARK: - Table view data source
extension CustomersTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        customers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let customer = customers[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = customer.name
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = CustomerDetails()
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

//MARK: - Private func
extension CustomersTableViewController {
    private func setUpButton() {
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        backButton.tintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
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
}
