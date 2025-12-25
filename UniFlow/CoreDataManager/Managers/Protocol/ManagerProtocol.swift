//
//  EventManager.swift
//  UniFlow
//
//  Created by Алексей on 17.07.2025.
//

import Foundation
import CoreData

protocol ManagerProtocol: AnyObject {
    func createEvent<T: MappableProtocol>(from dto: T, completion: @escaping (Result<[T.Entity], Error>) -> Void)
    func fetch<T: NSManagedObject>(of type: T.Type, completion: @escaping ([T]) -> Void)
}


