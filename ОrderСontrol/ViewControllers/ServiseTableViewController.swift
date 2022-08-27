//
//  ServiseTableViewController.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 27.08.2022.
//

import UIKit

private let reuseIdentifier = "cell"

class ServiseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK: - Table view data source
extension ServiseTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)


        return cell
    }
}

extension ServiseTableViewController {
    
}
