//
//  RowOfOrderViewController.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 08.09.2022.
//

import UIKit

protocol RowsViewControllerDelegate {
    func reloadData()
}

class RowsOfOrderViewController: UITableViewController {
    
    var rows: [RowOfOrder] = []
    
    private let reuseIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        fetchData()
    }
}

// MARK: - Table view data source
extension RowsOfOrderViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let row = rows[indexPath.row]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        
        let nameOfCustomer = (row.order?.customer == nil) ? "-- Unknown --" : (row.order?.customer?.name)
        
        var content = cell.defaultContentConfiguration()
        content.text = formatter.string(from: row.order?.date ?? Date()) + "\t" + (nameOfCustomer ?? "")
        
        cell.contentConfiguration = content

        return cell
    }
}

// MARK: - Table view delegate
extension RowsOfOrderViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension RowsOfOrderViewController {
    private func fetchData() {
        StorageManager.shared.fetchRows { result in
            switch result {
            case .success(let rowList):
                rows = rowList
            case .failure(let error):
                print("Don't fetch data - \(error.localizedDescription)")
            }
        }
    }
}

extension RowsOfOrderViewController: RowsViewControllerDelegate {
    func reloadData() {
        fetchData()
        tableView.reloadData()
    }
}
