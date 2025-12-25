//
//  EventsMapping.swift
//  UniFlow
//
//  Created by Алексей on 17.07.2025.
//

import Foundation
import CoreData

struct EventsMapping: MappingProtocol {
    static func map(from dto: EventsDTO, for context: NSManagedObjectContext) -> [Event] {
        return dto.map { event in
            let eventObject = Event(context: context)
            eventObject.id = UUID()
            eventObject.classroom = event.data.classroom
            eventObject.class_code = event.data.class_code
            eventObject.time_range = event.data.time_range
            eventObject.descriptions = event.data.description
            eventObject.is_cancelled = event.data.is_cancelled
            eventObject.session_type = event.data.session_type
            eventObject.delivery_mode = event.data.delivery_mode
            eventObject.instructor_name = event.data.instructor_name

            return eventObject
        }
    }
    
    typealias Entity = Event
    
    typealias DTO = EventsDTO
}
