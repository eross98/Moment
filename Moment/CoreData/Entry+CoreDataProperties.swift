//
//  Entry+CoreDataProperties.swift
//  Moment
//
//  Created by Evan Ross on 8/1/20.
//  Copyright © 2020 Evan. All rights reserved.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var month: Int64
    @NSManaged public var dayInt: Int64
    @NSManaged public var dayString: String?
    @NSManaged public var year: Int64
    @NSManaged public var time: Int64

}
