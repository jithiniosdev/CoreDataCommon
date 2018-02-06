//
//  CoreDataFunctions.swift
//  CoreDataCommon
//
//  Created by Appzoc on 31/01/18.
//  Copyright © 2018 appzoc. All rights reserved.
//

import UIKit
import CoreData

class CoreDataFunctions: NSObject {

    static var Details :[NSManagedObject] = []
    static var dataCount = 0
    static func fetchCarDetails(entityName : String)
    {
        // Fetching all datas under this entity name
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            Details = try managedContext.fetch(fetchRequest)
            dataCount = Details.count
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    static func addAction(entityName: String,key: String,value: String)
    {
        // ADDING
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let entity =
            NSEntityDescription.entity(forEntityName: entityName,
                                       in: managedContext)!
        let car = NSManagedObject(entity: entity,
                                  insertInto: managedContext)
        car.setValue(value, forKeyPath: key)
        
        
        do {
            try managedContext.save()
            fetchCarDetails(entityName: entityName)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        //ADDING END
    }
    
    static func show()
    {
        
            if dataCount != 0
             {
               for i in 0..<dataCount
                {
                  let carName = Details[i]
                    if let name: String = carName.value(forKey: "username") as? String
                    {
                        print(name)
                    }
                    
                    if let pswd: String = carName.value(forKey: "password") as? String
                    {
                        print(pswd)
                    }
                }
            }
    }
    
    static func delete ()
    {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        print(dataCount)
        print(Details.count)
        for i in 0..<dataCount
        {
            managedContext.delete(self.Details[0] as NSManagedObject)
        
            self.Details.remove(at: 0)
        
            let _ : NSError! = nil
            do {
                try managedContext.save()
            } catch {
                print("error : \(error)")
            }
        }
    }
}
