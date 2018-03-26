//
//  DetailTutorViewController.swift
//  TutorBoard
//
//  Created by Adrian on 3/23/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import UIKit
import CoreData

class DetailTutorViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var tutor_id: String = ""
    var tutor_profile: Tutor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        if tutor_id != nil {
            tutor_profile = CoreDataManager().fetchSingleUser(userid: tutor_id)
        } else {
            print("it is nilllllllll")
        }
        
    }

}

extension DetailTutorViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = Bundle.main.loadNibNamed("CustomCell", owner: self, options: nil) as! [CustomCell]
        
        if indexPath.section == 0 {
            cells[0].name.text = tutor_profile.firstname! + tutor_profile.lastname!
            cells[0].subject.text = tutor_profile.subject!
            cells[0].request_button.addTarget(self, action: #selector(request_action), for: .touchUpInside)
            return cells[0]
        }
        return cells[1]
    }
    
    @objc func request_action(sender: UIButton){
        SegueManager().toChatViewController(receiver: tutor_profile.uniqueid!, navController: navigationController!)
    }
    
    // modify the cell's custom height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cells = Bundle.main.loadNibNamed("CustomCell", owner: self, options: nil) as! [CustomCell]
        
        if indexPath.section == 0 {
            return cells[0].frame.height
        } else {
            return cells[1].frame.height
        }
    }
    
    
}
