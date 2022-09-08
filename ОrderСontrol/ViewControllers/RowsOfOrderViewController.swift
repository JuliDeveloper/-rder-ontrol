//
//  RowOfOrderViewController.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 08.09.2022.
//

import UIKit

class RowsOfOrderViewController: UITableViewController {
    
    var rows: [RowOfOrder] = []
    
    private let reuseIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
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
        
        let detailsVC = DetailsRowViewController()
        let nameOfService = row.service != nil ? row.service?.name : "???"
        let priceText = detailsVC.priceTextField.text
        
        var content = cell.defaultContentConfiguration()
        content.text = "\(nameOfService ?? "") - \(priceText ?? "0.0")"
        cell.contentConfiguration = content

        return cell
    }
}

// MARK: - Table view delegate
extension RowsOfOrderViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
