//
//  State+CoreDataProperties.swift
//  StatesAndTerritories
//
//  Created by Jovito Royeca on 14/11/2018.
//  Copyright © 2018 Jovito Royeca. All rights reserved.
//
//

import Foundation
import CoreData


extension State {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<State> {
        return NSFetchRequest<State>(entityName: "State")
    }

    @NSManaged public var name: String?
    @NSManaged public var nameSection: String?
    @NSManaged public var id: Int32
    @NSManaged public var abbreviation: String?
    @NSManaged public var capital: String?
    @NSManaged public var largestCity: String?
    @NSManaged public var area: String?
    @NSManaged public var country: String?

}
