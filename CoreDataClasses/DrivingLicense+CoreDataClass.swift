//
//  DrivingLicense+CoreDataClass.swift
//  CoreData-OneToOne
//
//  Created by Devi on 05/04/18.
//  Copyright © 2018 Devi. All rights reserved.
//
//

import Foundation
import CoreData


public class DrivingLicense: NSManagedObject {
    class func saveDetails(address : String, drivingSchoolName : String, fatherName : String, candidateName : String, rtoOfficeName : String, peronObj : Person, dateOfBirth : String, expiryDate: String, issuedDate: String, vehicleType: String) -> DrivingLicense
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
        drivingLicenseObj.dateOfBirth = dateOfBirth
        drivingLicenseObj.expiryDate = expiryDate
        drivingLicenseObj.issuedDate = issuedDate
        drivingLicenseObj.vehicleType = vehicleType
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
    
    class func updateContent(name : String, address : String, fatherName : String, drivingSchoolName: String, updatedPersonObj : NSManagedObjectID, rtoOfficeName: String, dob : String, issuedDate: String, vehicleType: String) -> Bool
    {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let license = managedContext.object(with: updatedPersonObj)
        
        let licenseObj = license as! DrivingLicense
        licenseObj.name = name
        licenseObj.address = address
        licenseObj.fatherName = fatherName
        licenseObj.drivingSchoolName = drivingSchoolName
        licenseObj.rtoOfficeName = rtoOfficeName
        licenseObj.dateOfBirth = dob
        licenseObj.issuedDate = issuedDate
        licenseObj.vehicleType = vehicleType
        licenseObj.updatedAt = NSDate()
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
    
    class func deleteOperation(license: DrivingLicense) -> Bool {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            managedContext.delete(license)
            try managedContext.save()
        }  catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        return true
    }
}

