//
//  ConversationIDmodel.swift
//  TutorBoard
//
//  Created by Adrian on 4/1/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import Foundation
import FirebaseDatabase

class contactModel: NSObject {
    
    var name: String!
    var date: String!
    var text: String!
    var profilePic: String!
    var otherClientID: String!
    
    override init() {
        super.init()
    }
    
    //parse the data (for sign up process)
    init(data: DataSnapshot, ConersationID: String) {
        let clientID = ConersationID.replacingOccurrences(of: FirebaseManager().userID(), with: "")
        
        let otherClient = CoreDataManager().fetchSingleUser(userid: clientID, completion: {_ in })
        self.name = otherClient.firstname!
        self.profilePic = otherClient.profilePic!
        
        let postDict = data.value as? [String : AnyObject] ?? [:]
        let timestamp = NSDate(timeIntervalSince1970: TimeInterval(truncating: postDict["date"] as! NSNumber))
        self.text = postDict["text"] as! String
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MMM d, h:mm a"
        self.date = dateformatter.string(from: timestamp as Date)
        
        self.otherClientID = clientID
    }
    
}
