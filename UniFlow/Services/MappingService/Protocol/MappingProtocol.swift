//
//  MappingProtocol.swift
//  UniFlow
//
//  Created by Алексей on 17.07.2025.
//

import Foundation
import CoreData

protocol MappingProtocol {
    associatedtype Entity: NSManagedObject
    associatedtype DTO: Decodable
    static func map(from dto: DTO, for context: NSManagedObjectContext) -> [Entity]
}
