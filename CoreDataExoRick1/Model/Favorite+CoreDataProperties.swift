//
//  Favorite+CoreDataProperties.swift
//  CoreDataExoRick1
//
//  Created by roman domasik on 16/02/2024.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var name: String

}

extension Favorite : Identifiable {

}
