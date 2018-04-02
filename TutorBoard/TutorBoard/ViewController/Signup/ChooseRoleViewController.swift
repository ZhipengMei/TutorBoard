//
//  ChooseRoleViewController.swift
//  TutorBoard
//
//  Created by Adrian on 3/22/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import UIKit

class ChooseRoleViewController: UIViewController {

    var newUserInfo: UserProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func createaTutorAccount(_ sender: Any) {
        createAccount(role: "Tutor")
    }
    
    @IBAction func createStudentAccount(_ sender: Any) {
        createAccount(role: "Student")
    }
    
    func createAccount(role: String) {
        view.endEditing(true)
        newUserInfo?.role = role
        
        //create a new user account
        FirebaseManager().FirebaseCreateAccountController(newUser: newUserInfo!, completion: {(isFinished) -> () in
            if isFinished == true {
                //fetch current user's info into coredata
                FirebaseManager().FireBaseFetchSingleUser(userid: FirebaseManager().userID(), completion: {_ in})
                //SegueManager().toTabBar(controller: self)
                SegueManager().toTabBar(navController: self.navigationController!)
            } else {
                print("Error: Signup failed")
            }
        })

    }

}
