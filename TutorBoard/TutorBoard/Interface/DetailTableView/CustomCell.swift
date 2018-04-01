//
//  CustomCell.swift
//  TutorBoard
//
//  Created by Adrian on 3/24/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    // Tutor Cell
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var request_button: UIButton!
    @IBOutlet weak var bio_textview: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    
    
    // Review Cell
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
