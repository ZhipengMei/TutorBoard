//
//  FirebaseManager.swift
//  TutorBoard
//
//  Created by Adrian on 3/22/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import Firebase
import CoreData

class FirebaseManager: NSObject {

    // MARK: - Auth
    
    // check user persist
    func isFirebaseUserSignedIn(completion: @escaping (Bool)->()) {
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                print("Success: signed in")
                completion(true)
            } else {
                print("Error: Not signed in")
                completion(false)
            }
        }
    }
    
    //create account with email & password
    func FirebaseCreateAccountController(newUser: UserProfile, completion: @escaping (Bool)->()) {
        Auth.auth().createUser(withEmail: newUser.email, password: newUser.password) { (user, error) in
            if error != nil {
                print("Error: Unable to create user account")
                completion(false)
            }
            else {
                //modify unique ID in newUser
                newUser.uniqueid = self.userID()
                
                //update database with new user profile
                self.FirebaseUpdateCurrentUserProfile(user_dict: newUser.UserProfileToDictionary())
                
                //sign in as current user
                self.FirebaseLoginController(email: newUser.email, password: newUser.password, completion: {_ in })
                
                print("Success: Created new user account")
                completion(true)
            }
        }
    }

    // login with email & password
    func FirebaseLoginController(email: String, password: String, completion: @escaping (Bool)->()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print("Error: Unable to login")
                completion(false)
            }
            else {
                print("Success: Login current user")
                completion(true)
            }
        }
    }
    
    //log out current user
    func FirebaseLogout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("Success: Logged out")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    //current user ID
    func userID() -> String {
        return Auth.auth().currentUser!.uid
    }

    // MARK: - Database
    
    //firebase data reference
    let ref = Database.database().reference()
    
    // upload new user's data
    func FirebaseUpdateCurrentUserProfile(user_dict: Dictionary<String, String>) {
        ref.child("users").child(user_dict["role"]!).child(userID()).setValue(user_dict)
        print("Success: Updated user's profile")
    }
    
    // fetch Tutor's info (download once)
    func FirebaseFetchTutors(completion: @escaping ([UserProfile])->()) {
        
        ref.child("users").child("Tutor").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let tutors:[UserProfile] = UserProfile().parseMultipleDataSnapshot(data: snapshot)
            
            //save tutors dictionary into CoreData
            CoreDataManager().SaveTutorObjectToCoreData(Tutors: tutors)
            
            //return tutors dictionary
            completion(tutors)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    
}

