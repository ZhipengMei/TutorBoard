//
//  UserProfile.swift
//  TutorBoard
//
//  Created by Adrian on 3/22/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import Foundation
import FirebaseDatabase

// Firebase Network Fetch -> userProfile -> UI display
class UserProfile: NSObject {
    
    var firstname: String!
    var lastname: String!
    var email: String!
    var subject: String!
    var password: String!
    var role: String!
    var uniqueid: String!
    var bio: String!
    var profilePic: String!
    
    override init() {
        super.init()
    }
    
    //parse the data (for sign up process)
    init(data: NSArray) {
        self.firstname = data[0] as! String
        self.lastname = data[1] as! String
        self.email = data[2] as! String
        self.subject = data[3] as! String
        self.password = data[4] as! String
        self.role = data[5] as! String
        self.uniqueid = data[6] as! String
        self.bio = data[7] as! String
        self.profilePic = data[7] as! String
    }
    
    init(data: DataSnapshot) {
        self.firstname = data.childSnapshot(forPath: "firstname").value! as! String
        self.lastname = data.childSnapshot(forPath: "lastname").value! as! String
        self.email = data.childSnapshot(forPath: "email").value! as! String
        self.subject = data.childSnapshot(forPath: "subject").value! as! String
        self.role = data.childSnapshot(forPath: "role").value! as! String
        self.uniqueid = data.childSnapshot(forPath: "uniqueid").value! as! String
        self.bio = data.childSnapshot(forPath: "bio").value! as! String
        self.profilePic = data.childSnapshot(forPath: "profilePic").value! as! String
    }
    
    // create a dictionary for upload data to firebase
    func UserProfileToDictionary() -> Dictionary<String, String> {
        let dict_data = ["firstname": self.firstname!,
                         "lastname": self.lastname!,
                         "email": self.email!,
                         "subject": self.subject!,
                         "role": self.role!,
                         "uniqueid": self.uniqueid!,
                         "bio": self.bio!,
                         "profilePic": self.profilePic!]
        return dict_data        
    }
    
    //parse returned firebase snapshot (one profile data)
    init(data: NSDictionary) {
        self.firstname = data["firstname"] as! String
        self.lastname = data["lastname"] as! String
        self.email = data["email"] as! String
        self.subject = data["subject"] as! String
        self.role = data["role"] as! String
        self.uniqueid = data["uniqueid"] as! String
        self.bio = data["bio"] as! String
        self.profilePic = data["profilePic"] as! String
    }
    
    
    //parse returned datasnapshots (multiple profile data)
    func parseMultipleDataSnapshot(data: DataSnapshot) -> [UserProfile] {
        //UserProfile array
        var tutors_data = [UserProfile]()
        //parse multiple DataSnapshot and append each one into tutors_data
        for child in data.children {
            if let value = (child as! DataSnapshot).value as? NSDictionary{
                let tutor = UserProfile(data: value)
                tutors_data.append(tutor)
            }
        }
        return tutors_data
    }
    
}
