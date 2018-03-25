//
//  SignupViewController.swift
//  TutorBoard
//
//  Created by Adrian on 3/22/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    var user_role: String!
    
    //textfield
    @IBOutlet weak var firstname_textfield: UITextField!
    @IBOutlet weak var lastname_textfield: UITextField!
    @IBOutlet weak var email_texxtfield: UITextField!
    @IBOutlet weak var subject_textfield: UITextField!
    @IBOutlet weak var password_textfield: UITextField!
    let uniqueid = "" //temporary placeholder
    
    //label
    @IBOutlet weak var role_label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        displayUI()
    }
    
    private func displayUI() {
        self.role_label.text = user_role
    }

    @IBAction func createaccount(_ sender: Any) {
        
        //put all user info into an array
        let data = [firstname_textfield.text!, lastname_textfield.text!, email_texxtfield.text!, subject_textfield.text!, password_textfield.text!, user_role, uniqueid]
        
        // create a user object
        let newUser = UserProfile(data: data as NSArray)
        
        //create a new user account
        FirebaseManager().FirebaseCreateAccountController(newUser: newUser, completion: {(isFinished) -> () in
            if isFinished == true {
                self.toTabBar()
            } else {
                print("11error")
            }
        })
    }
    
    private func toTabBar() {
        // go to Tab Bar
        if let tabBarController = storyboard?.instantiateViewController(withIdentifier:
            "TabBarController") as? TabBarController {
            present(tabBarController, animated: true, completion: nil)
        }
    }
    
    
    
    
}
