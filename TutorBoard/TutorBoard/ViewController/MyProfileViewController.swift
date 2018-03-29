//
//  DetailTutorTableViewController.swift
//  TutorBoard
//
//  Created by Adrian on 3/23/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import UIKit
import CoreData

class MyProfileViewController: UITableViewController {

    @IBOutlet weak var name_label: UILabel!
    @IBOutlet weak var subject_label: UILabel!
    var myprofile: Tutor!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myprofile = CoreDataManager().fetchSingleUser(userid: FirebaseManager().userID())
        //configureUIData()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func configureUIData() {
        name_label.text! = myprofile.firstname! + myprofile.lastname!
        subject_label.text! = myprofile.subject!
    }
    
    @IBAction func FirebaseLogout(_ sender: Any) {
        print("Logging out")
        FirebaseManager().FirebaseLogout()
        
        // go to SignIn Controller
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginNavigationController") as! UINavigationController
        self.present(vc, animated: true, completion: nil)
    }


    
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section < 1 {
            return 4
        } else {
            return 1
        }
        
    }

    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section > 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "reviewidentifier", for: indexPath)
//
//            // Configure the cell...
//
//            return cell
//        }
//
//    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



extension MyProfileViewController: NSFetchedResultsControllerDelegate {
    
    private func configureCell(cell: HomeTableViewCell, indexpath: IndexPath) {

//        let tutor = tutors.object(at: indexpath) as! Tutor
//        cell.name.text = tutor.firstname! + tutor.lastname!
//        cell.subject.text = tutor.subject
    }
    
    //default for NSFetchedResultsController
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    //default for NSFetchedResultsController
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break;
        case .update:
            if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) {
                //configureCell(cell: cell as! , indexpath: indexPath)
            }
            break;
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
            break;
        }
    }
    
}
