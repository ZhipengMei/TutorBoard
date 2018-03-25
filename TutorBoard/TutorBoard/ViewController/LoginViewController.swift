//
//  ViewController.swift
//  TutorBoard
//
//  Created by Adrian on 3/21/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import UIKit

class Login: UIViewController {

    @IBOutlet var userLogin: UITextField!
    @IBOutlet var userPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func Login(sender: AnyObject) {
        FirebaseManager().FirebaseLoginController(email: userLogin.text!, password: userPassword.text!, completion: {_ in })

    }
    
}

