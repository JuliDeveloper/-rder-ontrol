//
//  ServiseTableViewController.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 27.08.2022.
//

import UIKit

private let reuseIdentifier = "cell"

class ServicesTableViewController: UITableViewController {
    
    private let context = StorageManager.shared.context
    private var services: [Servise] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Services"
        
        tableView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        setUpButtons()
        fetchServise()
        tableView.reloadData()
    }
}

// MARK: - Table view data source
extension ServicesTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        services.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let service = services[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = service.name
        content.secondaryText = service.info
        cell.contentConfiguration = content
        
        return cell
    }
}

// MARK: - Table view delegate
extension ServicesTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let service = services[indexPath.row]
        
        showAlertController(with: "Edit service", and: "Change title or name", and: service.name ?? "", and: service.info ?? "", editService)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let service = services[indexPath.row]
        
        if editingStyle == .delete {
            services.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageManager.shared.deleteObject(object: service)
        }
    }
}

// MARK: - Private func's
extension ServicesTableViewController {
    private func fetchServise() {
        StorageManager.shared.fetchServise { result in
            switch result {
            case .success(let services):
                self.services = services
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setUpButtons() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewService))
        addButton.tintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        navigationItem.rightBarButtonItem = addButton
        
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        backButton.tintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    @objc private func addNewService() {
        showAlertController(with: "Add new servise",
                            and: "Add title and info",
                            and: "",
                            and: "",
                            saveNewService)
    }
    
    private func saveNewService(_ title: String, _ info: String) {
        let servise = Servise(context: context)
        
        servise.name = title
        servise.info = info
        
        services.append(servise)
        
        let cellIndex = IndexPath(row: services.count - 1, section: 0)
        tableView.insertRows(at: [cellIndex], with: .automatic)
        
        StorageManager.shared.saveContext()
    }
    
    private func editService(_ newTitle: String, _ newInfo: String) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        services[indexPath.row].name = newTitle
        services[indexPath.row].info = newInfo
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        StorageManager.shared.saveContext()
    }
}
