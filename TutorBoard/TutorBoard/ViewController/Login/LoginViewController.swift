//
//  ViewController.swift
//  TutorBoard
//
//  Created by Adrian on 3/21/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import UIKit

class Login: UIViewController, UITextFieldDelegate {

    @IBOutlet var userLogin: UITextField!
    @IBOutlet var userPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapDismissKeyboard()
        
        userLogin.delegate = self
        activateKeyboard()
    }
    
    func activateKeyboard() {
        userLogin.becomeFirstResponder()
    }
    

    
    @IBAction func Login(sender: AnyObject) {
        view.endEditing(true)
        FirebaseManager().FirebaseLoginController(email: userLogin.text!, password: userPassword.text!, completion: {(isFinished) -> () in
            //Login failed
            if isFinished == false {
                self.userLogin.text = ""
                self.userPassword.text = ""
            } else {
                //go to tab view
                SegueManager().toTabBar(controller: self)
            }
        })
    }
    
}



//dismiss keyboard
extension Login {
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

