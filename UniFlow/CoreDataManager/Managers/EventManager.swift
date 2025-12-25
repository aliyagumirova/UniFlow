//
//  EventManager.swift
//  UniFlow
//
//  Created by Алексей on 17.07.2025.
//

import Foundation
import CoreData

final class EventManager: ManagerProtocol {
    // MARK: – Container
    private let container: NSPersistentContainer
    
    // MARK: – Initializate
    init(container: NSPersistentContainer) {
        self.container = container
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // MARK: – Create
    func createEvent<T: MappableProtocol>(from dto: T, completion: @escaping (Result<[T.Entity], Error>) -> Void) {
        container.performBackgroundTask { context in
            do {
                let entities = try dto.map(in: context)
                try context.save()
                
                let objectIDs = entities.map { $0.objectID }
                
                DispatchQueue.main.async {
                    do {
                        let contextEntities = try objectIDs.map { objectID in
                            try self.container.viewContext.object(with: objectID) as! T.Entity
                        }
                        completion(.success(contextEntities))
                    } catch let error as NSError {
                        completion(.failure(error))
                    }
                }
            } catch let error as NSError {
                completion(.failure(error))
            }
        }
    }
    
    // MARK: – Read
    func fetch<T: NSManagedObject>(of type: T.Type, completion: @escaping ([T]) -> Void) {
        let fetchRequest = Event.fetchRequest()
        
        container.performBackgroundTask { context in
            do {
                let objects = try context.fetch(fetchRequest)
                let objectIDs = objects.map { $0.objectID }
                DispatchQueue.main.async {
                    let objectContext: [T] = objectIDs.compactMap { self.container.viewContext.object(with: $0) as? T }
                    completion(objectContext)
                }
            } catch let error as NSError {
                DispatchQueue.main.async {
                    completion([])
                }
                print("Fetch failed: \(error.localizedDescription)")
            }
        }
    }
}
