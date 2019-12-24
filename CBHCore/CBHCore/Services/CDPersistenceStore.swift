//
//  CDPersistenceStore.swift
//  CBHCards
//
//  Created by Deszip on 03.10.2019.
//  Copyright © 2019 Alty. All rights reserved.
//

import Foundation
import CoreData

protocol CDPersistenceStore: class {
    init(storeName: String, storeType: String)
    
    func uiContext() -> NSManagedObjectContext
    func backgroundContext() -> NSManagedObjectContext
    func perform(_ action: @escaping (NSManagedObjectContext) -> Void)
    func executeRequest(_ request: NSPersistentStoreRequest, in context: NSManagedObjectContext) throws -> Any
}

class CDPersistenceStoreImpl: CDPersistenceStore {
    
    private var container: NSPersistentContainer
    private let storeType: String
    
    required init(storeName: String, storeType: String) {
        self.storeType = storeType
        self.container = NSPersistentContainer(name: storeName)
        
        setupContainer()
    }
    
    private func setupContainer() {
        let storeDescription = NSPersistentStoreDescription()
        storeDescription.type = storeType
        storeDescription.shouldInferMappingModelAutomatically = true
        storeDescription.shouldMigrateStoreAutomatically = true
        container.persistentStoreDescriptions = [storeDescription]
        
        container.loadPersistentStores { (storeDescription, error) in
            if (error != nil) {
                print("Failed to load store: \(String(describing: error))")
            }
        }
    }
    
    func uiContext() -> NSManagedObjectContext {
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container.viewContext
    }
    
    func backgroundContext() -> NSManagedObjectContext {
        let context = container.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        return context
    }
    
    func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
        container.performBackgroundTask(action)
    }
    
    func executeRequest(_ request: NSPersistentStoreRequest, in context: NSManagedObjectContext) throws -> Any {
        try container.persistentStoreCoordinator.execute(request, with: context)
    }
}
