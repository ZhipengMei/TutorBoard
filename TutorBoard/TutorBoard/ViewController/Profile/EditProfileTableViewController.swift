
//
//  DetailTutorTableViewController.swift
//  TutorBoard
//
//  Created by Adrian on 3/23/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import UIKit
import CoreData
import FirebaseStorage
import FirebaseDatabase

class EditProfileTableViewController: UITableViewController {
    
    @IBOutlet weak var name_label: UILabel!
    @IBOutlet weak var subject_label: UILabel!
    @IBOutlet weak var profile_img: UIImageView!
    @IBOutlet weak var bio_textview: UILabel!
    @IBOutlet weak var image_cell: UITableViewCell!
    
    var myprofile: Tutor!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        myprofile = CoreDataManager().fetchSingleUser(userid: FirebaseManager().userID())
        configureUIData()
        tableView.reloadData()
    }
    
    //configuration of the UI
    func configureUIData() {
        name_label.text! = myprofile.firstname! + myprofile.lastname!
        subject_label.text! = myprofile.subject!
        bio_textview.text! = myprofile.bio!
        
        configureProfileImageCell()
        
        self.downloadImage("https://firebasestorage.googleapis.com/v0/b/bromance-e91d8.appspot.com/o/default_image%2Fprofile_pic_small.jpg?alt=media&token=d18e1e96-08b3-4eb7-81e3-9a0f73d904c9", inView: profile_img)

    }
    
    //tap gesture to activate image picker
    func configureProfileImageCell() {
        image_cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectedImageView)))
        image_cell.isUserInteractionEnabled = true
    }
    
    @objc private func handleSelectedImageView() {
        print("clicked handleSelectedImageView")
        self.chooseImage()
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
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        if segue.identifier == "toUpdateBio" {
            let vc = segue.destination as! UpdateBioViewController
            vc.thisUser = myprofile
        }
     }
 
    
}

//
extension EditProfileTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //display the image picker
    func chooseImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    //do something with the selected image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedPhotoFromPicker: UIImage?
        
        if let selectEditiedPhoto = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedPhotoFromPicker = selectEditiedPhoto
        } else if let selectedOriginPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedPhotoFromPicker = selectedOriginPhoto
        }
        
        if let selectedPhoto = selectedPhotoFromPicker {
            dismiss(animated: true, completion: nil)
            //override the current imageview
            self.profile_img.image = selectedPhoto
            
            //upload photo to firebase storage
            FirebaseManager().updateProfileWithPhoto(image: selectedPhoto, uid: myprofile.uniqueid!, role: myprofile.role!, completion: {_ in})
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}


/*
 Asynchronously
 Create a method with a completion handler to get the image data from your url
 Create a method to download the image (start the task)
*/
extension EditProfileTableViewController {
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


