//
//  ContactListViewController.swift
//  TutorBoard
//
//  Created by Adrian on 3/25/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

}

// MARK: - TableView
extension ContactListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell") as! ContactListCell
        configureCell(cell: cell, indexpath: indexPath)
        return cell
    }
    
    private func configureCell(cell: ContactListCell, indexpath: IndexPath) {
        cell.name_label.text = "omg"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

