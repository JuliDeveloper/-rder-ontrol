//
//  ServiseTableViewController.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 27.08.2022.
//

import UIKit

private let reuseIdentifier = "cell"

class ServiseTableViewController: UITableViewController {
    
    private var servicies: [Servise] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK: - Table view data source
extension ServiseTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        servicies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let service = servicies[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = service.name
        content.text = service.info
        cell.contentConfiguration = content
        
        return cell
    }
}

extension ServiseTableViewController {
    
}
