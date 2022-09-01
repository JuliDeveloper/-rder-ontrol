//
//  DocumentsTableViewController.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 29.08.2022.
//

import UIKit

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
        tableView.reloadData()
        
        createNewCell()
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
        let nameOfCustomer = order.customer == nil ? "--Unknown--" : order.customer?.name
        
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
        let documentVC = DetailsDocumentsViewController()
        documentVC.order = documents[indexPath.row]
    }
}

// MARK: - Private funcs
extension DocumentsTableViewController {
    private func setUpButtons() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(addNewDocuments))
        addButton.tintColor = Color.orangeColor
        navigationItem.rightBarButtonItem = addButton
        
        let backButton = UIBarButtonItem()
        backButton.tintColor = Color.backgroundColor
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    @objc private func addNewDocuments() {
        let detailsVC = DetailsDocumentsViewController()
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
    
    private func configCell(_ cell: UITableViewCell, _ order: Order) {
        
    }
    
    func createNewCell() {
        let order = Order(context: context)
        let detailsVC = DetailsDocumentsViewController()
        
        if detailsVC.isBeingDismissed {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                documents[selectedIndexPath.row] = order
                tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            } else {
                let indexPath = IndexPath(row: documents.count - 1, section: 0)
                documents.append(order)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
    }
}
