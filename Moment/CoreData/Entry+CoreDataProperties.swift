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
    /*
     init(month:Int64, dayInt:Int64, dayString:String, year:Int64, time:Int64)
       {
           self.month = month
           self.dayInt = dayInt
           self.dayString = dayString
           self.year = year
           self.time = time
           
       }
 */

    @NSManaged public var month: Int64
    @NSManaged public var dayInt: Int64
    @NSManaged public var dayString: String?
    @NSManaged public var year: Int64
    @NSManaged public var time: Int64

}
