//
//  ContinueButton.swift
//  TutorBoard
//
//  Created by Adrian on 3/29/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import UIKit

class ContinueButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    private func configureUI() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.backgroundColor = UIColor(red: 43/255, green: 89/255, blue: 162/255, alpha: 0.25)
    }
    
}
