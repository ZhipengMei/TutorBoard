//
//  ContactListCell.swift
//  TutorBoard
//
//  Created by Adrian on 3/25/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import UIKit

class ContactListCell: UITableViewCell {

    @IBOutlet weak var name_label: UILabel!
    @IBOutlet weak var text_label: UILabel!
    @IBOutlet weak var date_label: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
