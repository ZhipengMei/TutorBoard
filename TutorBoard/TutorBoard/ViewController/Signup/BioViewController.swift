//
//  BioViewController.swift
//  TutorBoard
//
//  Created by Adrian on 3/30/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import UIKit

class BioViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var bio_textview: UITextView!
    var newUserInfo: UserProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bio_textview.delegate = self
        bio_textview.isEditable = true
        activateKeyboard()
        tapDismissKeyboard()
    }
    
    func activateKeyboard() {
        bio_textview.becomeFirstResponder()
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //override the old bio data
        newUserInfo?.bio = bio_textview.text!
        
        let vc = segue.destination as! ChooseRoleViewController
        vc.newUserInfo = newUserInfo
    }


}

//dismiss keyboard
extension BioViewController {
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
