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
                self.FirebaseUpdateCurrentUserProfile(user_dict: newUser.UserProfileToDictionary(), completion: {(isFinished) in
                
                    if isFinished == true {
                        //upload default image
                        self.updateProfileWithPhoto(image: UIImage(named: "user")!, uid: newUser.uniqueid, role: newUser.role, completion: {_ in })
                    }
                    
                })
                
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
    
    //firebase data root reference
    let ref = Database.database().reference()
    
    // upload new user's data
    func FirebaseUpdateCurrentUserProfile(user_dict: Dictionary<String, String> , completion: @escaping (Bool)->()) {
        ref.child("users").child(user_dict["role"]!).child(userID()).setValue(user_dict)
        print("Success: Updated user's profile")
        completion(true)
    }
    
    // fetch Tutor's info (download once)
    func FirebaseFetchTutors(completion: @escaping ([UserProfile])->()) {
        ref.child("users").child("Tutor").observe(DataEventType.childAdded, with: { (snapshot) in
            
            let tutors:[UserProfile] = UserProfile().parseMultipleDataSnapshot(data: snapshot)
            
            //save tutors dictionary into CoreData
            CoreDataManager().SaveTutorObjectToCoreData(Tutors: tutors)
            
            //return tutors dictionary
            completion(tutors)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func FireBaseFetchSingleUser(userid: String, completion: @escaping (Bool)->()) {
        ref.child("users").child("Tutor").child(userid).observeSingleEvent(of: .value, with: { (snapshot) in

            //parse datasnapshot into Userprofile
            let tutor:UserProfile = UserProfile(data: (snapshot.value as? NSDictionary)!)
            
            //save tutors dictionary into CoreData
            CoreDataManager().SaveTutorObjectToCoreData(Tutors: [tutor])
            completion(true)
        }) { (error) in
            print(error.localizedDescription)
            completion(false)
        }
    }

    
    
    // MARK: - Storage
    
    // Create a root reference
    let storageRef = Storage.storage().reference()
    
    //upload file to firebas storage then link the storage to database
    func updateProfileWithPhoto(image: UIImage, uid: String, role: String, completion: @escaping (Bool)->()) {
        // Create a root reference
        let profilePicRef = storageRef.child(uid + "/profilePic.jpg")
        
        //compress image to lower quality, save stoage size
        let imageData = UIImageJPEGRepresentation(image, 0)
        //upload profile image into firebase
        profilePicRef.putData(imageData! as Data, metadata: nil, completion: {
            (metadata,error) in
            
            if error != nil {
                print(error!)
                completion(false)
                return
            }
            
            //download image url from storage
            let downloadUrl = metadata!.downloadURL
            let databaseRef = Database.database().reference().child("users").child(role).child(uid).child("profilePic")
            databaseRef.setValue(downloadUrl()!.absoluteString) //upload image url to database
            completion(true)
        })
    }
}

// MARK: - Saving Messages to Database
extension FirebaseManager {
    
    func UploadChatMessage(conversationID: String, message: Dictionary<String, Any>) {
        ref.child("Conversation").child(conversationID).childByAutoId().setValue(message)
    }
    
    //only listen to new child added
    func fetchMessages(conversationID: String, completion: @escaping (Dictionary<String, Any>)->()) {
        ref.child("Conversation").child(conversationID).observe(DataEventType.childAdded, with: { (snapshot) in
            //.value get the child data, ignoring the child's id
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            completion(postDict)
        })
    }
    
}


