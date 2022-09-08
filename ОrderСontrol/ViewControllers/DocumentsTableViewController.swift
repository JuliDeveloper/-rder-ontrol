//
//  DocumentsTableViewController.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 29.08.2022.
//

import UIKit

protocol DocumentViewControllerDelegate {
    func reloadData()
}

private let reuseIdentifier = "cell"

class DocumentsTableViewController: UITableViewController {
    
    private let context = StorageManager.shared.context

    var documents: [Order] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Orders"
        
        tableView.config()
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: reuseIdentifier)
        
        setUpButtons()
        
        fetchData()
    }
}

// MARK: - Table view data source
extension DocumentsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        documents.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let order = documents[indexPath.row]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        let nameOfCustomer = order.customer != nil ? order.customer?.name : "--Unknown--"
        
        var content = cell.defaultContentConfiguration()
        content.text = formatter.string(from: order.date ?? Date()) + "\t" + (nameOfCustomer ?? "")
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let order = documents[indexPath.row]
        if editingStyle == .delete {
            documents.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageManager.shared.deleteObject(object: order)
        }
    }
}

// MARK: - Table view delegate
extension DocumentsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let order = documents[indexPath.row]
        
        let documentVC = DetailsDocumentsViewController()
        documentVC.order = order
        documentVC.customerTextField.text = order.customer?.name
        documentVC.datePicker.date = order.date ?? Date()
        documentVC.switcherPaid.isOn = order.paid
        documentVC.switcherMade.isOn = order.made
        documentVC.delegate = self
        
        navigationController?.pushViewController(documentVC, animated: true)
    }
}

// MARK: - Private funcs
extension DocumentsTableViewController {
    private func setUpButtons() {
        navigationController?.setUpBackButtons()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(addNewDocuments))
        addButton.tintColor = Color.orangeColor
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addNewDocuments() {
        let detailsVC = DetailsDocumentsViewController()
        detailsVC.delegate = self
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    private func fetchData() {
        StorageManager.shared.fetchDocuments { result in
            switch result {
            case .success(let documents):
                self.documents = documents
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension DocumentsTableViewController: DocumentViewControllerDelegate {
    func reloadData() {
        fetchData()
        tableView.reloadData()
    }
}
