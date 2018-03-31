//
//  UpdateBioViewController.swift
//  TutorBoard
//
//  Created by Adrian on 3/30/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import UIKit

class UpdateBioViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var bio_textview: UITextView!
    var thisUser: Tutor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bio_textview.delegate = self
        bio_textview.isEditable = true
        activateKeyboard()
        tapDismissKeyboard()
        
        bio_textview.text = thisUser?.bio
    }

    func activateKeyboard() {
        bio_textview.becomeFirstResponder()
    }
    
    @IBAction func saveBio(_ sender: Any) {
        
        
        FirebaseManager().FirebaseUpdateOneAttribute(thisUser: thisUser!, attribute: "bio", newValue: bio_textview.text, completion: {(isFinished) -> () in
            
            self.thisUser?.bio = self.bio_textview.text
            if isFinished == true {
                //CoreDataManager().UpdateSingleUser(thisTutor: self.thisUser!)
                self.dismiss(animated: true, completion: nil)
            }
            
        })
    }

}

//dismiss keyboard
extension UpdateBioViewController {
    func tapDismissKeyboard() {
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
