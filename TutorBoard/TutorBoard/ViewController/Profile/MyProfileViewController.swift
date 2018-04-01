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
    @IBOutlet weak var bio_label: UILabel!
    @IBOutlet weak var profile_img: UIImageView!
    
    var myprofile: Tutor!
    var isDataReady = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myprofile = CoreDataManager().fetchSingleUser(userid: FirebaseManager().userID(), completion: {(isFinished) in
            if isFinished == true {
                self.isDataReady = true
            }
        })
        
        if isDataReady == true {
            self.configureUIData()
            self.tableView.reloadData()
        }
    }
    
    func configureUIData() {
        name_label.text! = myprofile.firstname! + " " + myprofile.lastname!
        bio_label.text! = myprofile.bio!
        ImageModel().downloadImage(myprofile.profilePic!, inView: profile_img)
    }
    
    @IBAction func FirebaseLogout(_ sender: Any) {
        print("Logging out")
        FirebaseManager().FirebaseLogout()
        
        // go to SignIn Controller
        SegueManager().toLoginNavigationController(controller: self)
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

/*
 Asynchronously
 Create a method with a completion handler to get the image data from your url
 Create a method to download the image (start the task)
 */
extension MyProfileViewController {
    func downloadImage(_ uri : String, inView: UIImageView){
        
        let url = URL(string: uri)
        
        let task = URLSession.shared.dataTask(with: url!) {responseData,response,error in
            if error == nil{
                if let data = responseData {
                    
                    DispatchQueue.main.async {
                        inView.image = UIImage(data: data)
                    }
                }else {
                    print("no data")
                }
            }else{
                print(error!)
            }
        }
        task.resume()
    }
    
}




