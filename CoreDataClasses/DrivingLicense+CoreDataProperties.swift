//
//  DrivingLicense+CoreDataProperties.swift
//  CoreData-OneToOne
//
//  Created by Devi on 05/04/18.
//  Copyright © 2018 Devi. All rights reserved.
//
//

import Foundation
import CoreData


extension DrivingLicense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DrivingLicense> {
        return NSFetchRequest<DrivingLicense>(entityName: "DrivingLicense")
    }

    @NSManaged public var address: String?
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var dateOfBirth: String?
    @NSManaged public var drivingSchoolName: String?
    @NSManaged public var expiryDate: String?
    @NSManaged public var fatherName: String?
    @NSManaged public var issuedDate: String?
    @NSManaged public var name: String?
    @NSManaged public var rtoOfficeName: String?
    @NSManaged public var updatedAt: NSDate?
    @NSManaged public var vehicleType: String?
    @NSManaged public var person: Person?

}
