//
//  File.swift
//  TutorBoard
//
//  Created by Adrian on 3/24/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import UIKit
import CoreData

// Firebase Network Fetch -> userProfile -> CoreData
class CoreDataManager {
    //coredata context
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //current user ID
    private let userID = FirebaseManager().userID()
    
    
    func SaveTutorObjectToCoreData(Tutors: [UserProfile]) {
        //managed context
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
        // initializing Tutor Entity
        let tutor_entity = NSEntityDescription.entity(forEntityName: "Tutor", in: context)
        //for (index, element) in Tutors.enumerated() {
        for element in Tutors {
            let tutor = NSManagedObject(entity: tutor_entity!, insertInto: context)
            //tutor.setValue(item, forKey: "name")
            tutor.setValuesForKeys(element.UserProfileToDictionary())        
        }
        try! context.save()
    }
    
    
    //default variable for NSFetchedResultsController for HomeVC
    lazy var home_frc: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tutor")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "firstname", ascending: false)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = HomeViewController()
        return frc
    }()
    
    func fetchSingleUser(userid: String) -> Tutor {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tutor")
        request.predicate = NSPredicate(format: "uniqueid = %@", userid)
        request.fetchLimit = 1
        request.returnsObjectsAsFaults = false
        let result = try! context.fetch(request) as! [Tutor]
        return result[0]
    }
    
    
}








