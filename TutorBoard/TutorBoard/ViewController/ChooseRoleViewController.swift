//
//  ChooseRoleViewController.swift
//  TutorBoard
//
//  Created by Adrian on 3/22/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import UIKit

class ChooseRoleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "StudentSegueIdentifier") {
            let vc = segue.destination as! SignupViewController
            vc.user_role = "Student"
        } else if (segue.identifier == "TutorSegueIdentifier") {
            let vc = segue.destination as! SignupViewController
            vc.user_role = "Tutor"
        }
    }


}
