//
//  DocumentsTableViewController.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 29.08.2022.
//

import UIKit

private let reuseIdentifier = "cell"

class DocumentsTableViewController: UITableViewController {
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
    }
}

// MARK: - Table view data source
extension DocumentsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        

        return cell
    }
}
