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
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        title = "Customers"
        tableView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = false
        
        fetchData()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        customers.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let customer = customers[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = customer.name
        content.image = UIImage(systemName: "dote.square")
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = CustomerDetails()
        navigationController?.pushViewController(detailsVC, animated: true)
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
