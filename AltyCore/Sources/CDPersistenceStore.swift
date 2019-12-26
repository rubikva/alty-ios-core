//
//  CDPersistenceStore.swift
//  CBHCards
//
//  Created by Deszip on 03.10.2019.
//  Copyright © 2019 Alty. All rights reserved.
//

import Foundation
import CoreData

public protocol CDPersistenceStore: class {
    init(storeName: String, storeType: String, modelURL: URL)
    
    func uiContext() -> NSManagedObjectContext
    func backgroundContext() -> NSManagedObjectContext
    func perform(_ action: @escaping (NSManagedObjectContext) -> Void)
    func executeRequest(_ request: NSPersistentStoreRequest, in context: NSManagedObjectContext) throws -> Any
}

public class CDPersistenceStoreImpl: CDPersistenceStore {
    
    private var container: NSPersistentContainer
    private let storeType: String
    
    public required init(storeName: String, storeType: String, modelURL: URL) {
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Couldn't find database momd")
        }
        self.storeType = storeType
        self.container = NSPersistentContainer(name: storeName, managedObjectModel: managedObjectModel)
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
    
    public func uiContext() -> NSManagedObjectContext {
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container.viewContext
    }
    
    public func backgroundContext() -> NSManagedObjectContext {
        let context = container.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        return context
    }
    
    public func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
        container.performBackgroundTask(action)
    }
    
    public func executeRequest(_ request: NSPersistentStoreRequest, in context: NSManagedObjectContext) throws -> Any {
        try container.persistentStoreCoordinator.execute(request, with: context)
    }
}
