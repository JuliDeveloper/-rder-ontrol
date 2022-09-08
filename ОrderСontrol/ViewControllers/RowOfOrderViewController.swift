//
//  RowOfOrderViewController.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 08.09.2022.
//

import UIKit

class RowOfOrderViewController: UITableViewController {
    
    var rows: [Service] = []
    
    private let reuseIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)


        return cell
    }
}
