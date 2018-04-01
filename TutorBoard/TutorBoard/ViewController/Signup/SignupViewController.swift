//
//  SignupViewController.swift
//  TutorBoard
//
//  Created by Adrian on 3/22/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {

    //textfield
    @IBOutlet weak var firstname_textfield: UITextField!
    @IBOutlet weak var lastname_textfield: UITextField!
    @IBOutlet weak var email_texxtfield: UITextField!
    @IBOutlet weak var subject_textfield: UITextField!
    @IBOutlet weak var password_textfield: UITextField!
    let bio = ""
    let profilePic = ""
    let role = ""
    let uniqueid = "" //temporary placeholder
    let contactList = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapDismissKeyboard()
        
        firstname_textfield.delegate = self
        activateKeyboard()
    }
    
    func activateKeyboard() {
        firstname_textfield.becomeFirstResponder()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! BioViewController
        
        //put all user info into an array
        let data = [firstname_textfield.text!,
                    lastname_textfield.text!,
                    email_texxtfield.text!,
                    subject_textfield.text!,
                    password_textfield.text!,
                    role,
                    uniqueid,
                    bio,
                    profilePic,
                    contactList] as [Any]
        
        // create a user object
        let newUser = UserProfile(data: data as NSArray)
        vc.newUserInfo = newUser
    }
    
}

//dismiss keyboard
extension SignupViewController {
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

