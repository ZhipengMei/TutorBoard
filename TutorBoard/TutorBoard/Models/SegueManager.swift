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
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func toChatViewController(receiver: String, navController: UINavigationController){
        let vc = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        vc.receiver = receiver
        navController.pushViewController(vc, animated: true)
    }
    
    func toDrawViewController(navController: UINavigationController) {
        let vc = storyboard.instantiateViewController(withIdentifier: "DrawViewController") as! DrawViewController
        navController.pushViewController(vc, animated: true)
    }

    // go to Tab Bar
//    func toTabBar(controller: UIViewController) {
//        if let tabBarController = storyboard.instantiateViewController(withIdentifier:
//            "TabBarController") as? TabBarController {
//            controller.present(tabBarController, animated: true, completion: nil)
//        }
//    }
    func toTabBar(navController: UINavigationController) {
        if let tabBarController = storyboard.instantiateViewController(withIdentifier:
            "TabBarController") as? TabBarController {
            navController.pushViewController(tabBarController, animated: true)
                //.present(tabBarController, animated: true, completion: nil)
        }
    }
    
    func toLoginNavigationController(controller: UIViewController) {
        // go to SignIn Controller
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginNavigationController") as! UINavigationController
        controller.present(vc, animated: true, completion: nil)
    }
    
    func hideNavBar(navController: UINavigationController) {
        navController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.isTranslucent = true
        navController.view.backgroundColor = UIColor.clear
    }
    

    
}
