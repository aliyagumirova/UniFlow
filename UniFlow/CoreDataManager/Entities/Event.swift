//
//  Events+CoreDataProperties.swift
//  UniFlow
//
//  Created by Алексей on 17.07.2025.
//
//

import Foundation
import CoreData

@objc(Event)
public class Event: NSManagedObject { }

extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var date: String?
    @NSManaged public var classroom: String?
    @NSManaged public var class_code: String?
    @NSManaged public var time_range: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var is_cancelled: Bool
    @NSManaged public var session_type: String?
    @NSManaged public var delivery_mode: String?
    @NSManaged public var instructor_name: String?

}

extension Event : Identifiable { }
