//
//  DrivingLicense+CoreDataClass.swift
//  CoreData-OneToOne
//
//  Created by Devi on 02/04/18.
//  Copyright © 2018 Devi. All rights reserved.
//
//

import Foundation
import CoreData


public class DrivingLicense: NSManagedObject {
    class func saveDetails(address : String, drivingSchoolName : String, fatherName : String, candidateName : String, rtoOfficeName : String, peronObj : Person) -> DrivingLicense
    {
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity =  NSEntityDescription.entity(forEntityName: "DrivingLicense",
                                                 in:managedContext)
        let drivingLicenseObj = NSManagedObject(entity: entity!,
                                                insertInto: managedContext) as! DrivingLicense
        
        drivingLicenseObj.name = candidateName
        drivingLicenseObj.address = address
        drivingLicenseObj.drivingSchoolName = drivingSchoolName
        drivingLicenseObj.fatherName = fatherName
        drivingLicenseObj.rtoOfficeName = rtoOfficeName
        drivingLicenseObj.createdAt = NSDate()
        drivingLicenseObj.updatedAt = NSDate()
        drivingLicenseObj.person = peronObj
        do {
            try managedContext.save()
            print("person obj", drivingLicenseObj)
            return drivingLicenseObj
        }
        catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        return drivingLicenseObj
    }
    
    class func fetchDetails(selectedPerson : Person)  -> DrivingLicense? {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DrivingLicense")
        do {
            let drivingLicenseArray = try managedContext.fetch(fetchRequest)
            if let dlArray = drivingLicenseArray as? [DrivingLicense] {
                for license in dlArray {
                    if let lPerson = license.person {
                        let dl = lPerson
                        print("ddddll", dl)
                        return license
                    }
                }
            }
        }
        catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        return nil
    }
}
