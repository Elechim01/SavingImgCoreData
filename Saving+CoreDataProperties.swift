//
//  Saving+CoreDataProperties.swift
//  SavingImgCoreData
//
//  Created by Michele on 14/01/21.
//
//

import Foundation
import CoreData


extension Saving {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Saving> {
        return NSFetchRequest<Saving>(entityName: "Saving")
    }

    @NSManaged public var user: String?
    @NSManaged public var imageD: Data?
    @NSManaged public var favo: Bool
    @NSManaged public var descriptions: String?

}

extension Saving : Identifiable {

}
