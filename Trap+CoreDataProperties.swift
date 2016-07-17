//
//  Trap+CoreDataProperties.swift
//  trap
//
//  Created by Gopal Shah on 7/16/16.
//  Copyright © 2016 Kabir Shah. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Trap {

    @NSManaged var lat: NSNumber?
    @NSManaged var lon: NSNumber?

}
