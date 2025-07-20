//
//  Event.swift
//  UniFlow
//
//  Created by Алексей on 17.07.2025.
//

import Foundation
import CoreData

typealias EventsDTO = [EventDTO]

struct EventDTO: Decodable {
    let id: String
    let created_date: String
    let modified_date: String
    let project_id: String
    let account_id: String
    let user_id: String
    let object_type: String
    let object_item: String
    let object_code: String
    let name: String
    let meta: MetaDTO
    let data: DataDTO
}

struct MetaDTO: Decodable {
    let flags: Int
    let status: String
    let internal_id: Int
}

struct DataDTO: Decodable {
    let date: String
    let classroom: String
    let class_code: String
    let time_range: String
    let description: String
    let is_cancelled: Bool
    let session_type: String
    let delivery_mode: String
    let instructor_name: String
}

extension EventsDTO: MappableProtocol {
    func map(in context: NSManagedObjectContext) throws -> [Event] {
        EventsMapping.map(from: self, for: context)
    }
    
    typealias Entity = Event
    
    
}
