//
//  Social+CoreDataProperties.swift
//  Meetsy
//
//  Created by APPLE on 11/09/22.
//
//

import Foundation
import CoreData


extension Social {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Social> {
        return NSFetchRequest<Social>(entityName: "Social")
    }

    @NSManaged public var platform: String?
    @NSManaged public var username: String?
    

}

extension Social : Identifiable {

}
