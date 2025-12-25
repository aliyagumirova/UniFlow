//
//  MappableProtocol.swift
//  UniFlow
//
//  Created by Алексей on 17.07.2025.
//

import Foundation
import CoreData

protocol MappableProtocol {
    associatedtype Entity: NSManagedObject
    func map(in context: NSManagedObjectContext) throws -> [Entity]
}
