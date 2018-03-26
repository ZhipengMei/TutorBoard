//
//  SegueManager.swift
//  TutorBoard
//
//  Created by Adrian on 3/26/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import UIKit

// This class perform segue/going to another view
class SegueManager {
    
    
    func toChatViewController(receiver: String, navController: UINavigationController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        vc.receiver = receiver
        navController.pushViewController(vc, animated: true)
    }
    
}
