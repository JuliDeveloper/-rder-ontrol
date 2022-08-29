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
        
        setUpButtons()
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

// MARK: - Private funcs
extension DocumentsTableViewController {
    private func setUpButtons() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewDocuments))
        addButton.tintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        navigationItem.rightBarButtonItem = addButton
        
        let backButton = UIBarButtonItem()
        backButton.tintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    @objc private func addNewDocuments() {
        let detailsVC = DetailsDocumentsViewController()
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
