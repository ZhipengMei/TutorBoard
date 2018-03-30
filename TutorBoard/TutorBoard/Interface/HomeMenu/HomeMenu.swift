//
//  HomeMenu.swift
//  TutorBoard
//
//  Created by Adrian on 3/29/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import UIKit

class HomeMenu: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide the navigation bar
        SegueManager().hideNavBar(navController: navigationController!)
    }
    
}
