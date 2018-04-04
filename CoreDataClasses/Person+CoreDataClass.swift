//
//  Person+CoreDataClass.swift
//  CoreData-OneToOne
//
//  Created by Devi on 02/04/18.
//  Copyright © 2018 Devi. All rights reserved.
//
//

import Foundation
import CoreData


public class Person: NSManagedObject {
    class func saveDetails(name : String, age : Int16, address : String, fatherName : String) -> Person
    {
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity =  NSEntityDescription.entity(forEntityName: "Person",
                                                 in:managedContext)
        let personObj = NSManagedObject(entity: entity!,
                                        insertInto: managedContext) as! Person
        
        personObj.name = name
        personObj.age = age
        personObj.address = address
        personObj.fatherName = fatherName
        personObj.createdAt = NSDate()
        personObj.updatedAt = NSDate()
        
        do
        {
            try managedContext.save()
            print("person obj", personObj)
            return personObj
        }
        catch let error as NSError
        {
            print("Could not save \(error), \(error.userInfo)")
        }
        return personObj
    }
    
    class func fetchDetails()  -> [Person]?
    {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do
        {
            let results =
                try managedContext.fetch(fetchRequest)
            return results as! [Person]
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return nil
    }
    
    class func deleteOperation(individualPerson: Person) -> Bool {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            managedContext.delete(individualPerson)
            try managedContext.save()
        }  catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        return true
    }
    
    class func updateContent(name : String, age : Int16, fatherName : String, address: String, updatedPersonObj : NSManagedObjectID) -> Bool
    {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let person = managedContext.object(with: updatedPersonObj)
        
        let personObj = person as! Person
        personObj.name = name
        personObj.age = age
        personObj.fatherName = fatherName
        personObj.address = address
        personObj.updatedAt = NSDate()
        do {
            try managedContext.save()
            return true
        }
        catch let error as NSError
        {
            print("Could not save \(error), \(error.userInfo)")
        }
        return true
        
    }
}
