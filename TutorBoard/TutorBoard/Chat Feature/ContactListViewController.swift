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
    var contactList = Array<String>()
    var contactModelList = [contactModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        FirebaseManager().fetchContactedList(completion: {(result) in
            self.contactList = result
            
            for conversationID in result {
                FirebaseManager().fetchConversation(conversationID: conversationID, completion: {(newcontactModel) in
                    //do something here with the result
                    self.contactModelList.append(newcontactModel)
                    self.tableView.reloadData()
                })
            }
        })
    }

}

// MARK: - TableView
extension ContactListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        SegueManager().toChatViewController(receiver: contactModelList[indexPath.row].otherClientID, navController: navigationController!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if contactList.count > 0{
            return contactList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell") as! ContactListCell
        configureCell(cell: cell, indexpath: indexPath)
        return cell
    }
    
    private func configureCell(cell: ContactListCell, indexpath: IndexPath) {
        cell.name_label.text = contactModelList[indexpath.row].name
        cell.text_label.text = contactModelList[indexpath.row].text
        cell.date_label.text = contactModelList[indexpath.row].date
        ImageModel().downloadImage(contactModelList[indexpath.row].profilePic, inView: cell.imageview)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

