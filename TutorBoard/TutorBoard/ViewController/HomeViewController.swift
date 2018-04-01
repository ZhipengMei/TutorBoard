//
//  HomeViewController.swift
//  
//
//  Created by Adrian on 3/22/18.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var tutors = NSFetchedResultsController<NSFetchRequestResult>()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
        
        //TableViewHeight
        tableview.estimatedRowHeight = 44
        tableview.rowHeight = UITableViewAutomaticDimension
        
        FirebaseManager().FirebaseFetchTutors(completion: {(returnedTutors) -> () in
            //self.tutors = returnedTutors
            self.tutors = CoreDataManager().home_frc
            try! self.tutors.performFetch()
            
            //maybe optional to reload
            self.tableview.reloadData()
        })
        
        FirebaseManager().FirebaseFetchTutorChildChanged(completion: {(returnedTutors) -> () in
        
            self.tableview.reloadData()
        })
    }

    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "toDetailTutor") {
//            let vc = segue.destination as! DetailTutorViewController
//            vc.tutor_id = tutorIDtoPass
//        }
//    }
 

}


// MARK: - TableView
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected_tutor = tutors.object(at: indexPath) as! Tutor
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailTutorViewController") as! DetailTutorViewController
        vc.tutor_id = selected_tutor.uniqueid!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return tutors.count
        if let count = tutors.fetchedObjects?.count {
            return count - 1
        }        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        configureCell(cell: cell, indexpath: indexPath)
        return cell
    }
    
    private func configureCell(cell: HomeTableViewCell, indexpath: IndexPath) {
        let tutor = tutors.object(at: indexpath) as! Tutor
        
        if tutor.uniqueid! != FirebaseManager().userID() {
            print(tutor.uniqueid!)
            print(FirebaseManager().userID())
            cell.name.text = tutor.firstname! + tutor.lastname!
            cell.subject.text = tutor.subject
            ImageModel().downloadImage(tutor.profilePic!, inView: cell.imageview)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}






// MARK: - FRC
extension HomeViewController: NSFetchedResultsControllerDelegate {
    
    //default for NSFetchedResultsController
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableview.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableview.endUpdates()
    }
    
    //default for NSFetchedResultsController
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableview.insertRows(at: [indexPath], with: .fade)
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                tableview.deleteRows(at: [indexPath], with: .fade)
            }
            break;
        case .update:
            if let indexPath = indexPath, let cell = tableview.cellForRow(at: indexPath) {
                configureCell(cell: cell as! HomeTableViewCell, indexpath: indexPath)
            }
            break;
        case .move:
            if let indexPath = indexPath {
                tableview.deleteRows(at: [indexPath], with: .fade)
            }
            
            if let newIndexPath = newIndexPath {
                tableview.insertRows(at: [newIndexPath], with: .fade)
            }
            break;
        }
    }
    
}









