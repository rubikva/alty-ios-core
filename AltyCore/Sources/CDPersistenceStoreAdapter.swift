//
//  CDPersistenceStoreAdapter.swift
//  CBHCards
//
//  Created by Deszip on 04.10.2019.
//  Copyright © 2019 Alty. All rights reserved.
//

import CoreData

public class CDPersistenceStoreAdapter<Entity: NSManagedObject>: NSObject, NSFetchedResultsControllerDelegate {
    private weak var store: CDPersistenceStore?
    private var request: NSFetchRequest<Entity>
    private var sectionKeyPath: String?
    private var frc: NSFetchedResultsController<Entity>?
    
    // MARK: - Init -
    
    public init(request: NSFetchRequest<Entity>, sectionKeyPath: String? = nil) {
        self.request = request
        self.sectionKeyPath = sectionKeyPath
    }
    
    // MARK: - CBHStoreAdapter
    
    public var contentChangedCallback: (() -> ())?
    public var objectChangedCallback: ((IndexPath?, NSFetchedResultsChangeType, IndexPath?) -> ())?
    
    public var allItems: [Entity] {
        guard let sections = frc?.sections else { return [] }
        var allObjects: [Entity] = []
        for (index, _) in sections.enumerated() {
            allObjects.append(contentsOf: itemsInSection(index))
        }
        return allObjects
    }

    public func updateFetchRequest(with newRequest: NSFetchRequest<Entity>) {
        self.request = newRequest
        self.frc?.fetchRequest.predicate = newRequest.predicate
        fetch()
    }
    
    public func bind(to store: CDPersistenceStore, with predicate: NSPredicate? = nil) {
        self.store = store
        buildFRC(with: predicate)
        fetch()
    }
    
    public func sectionsCount() -> Int {
        return frc?.sections?.count ?? 0
    }
    
    public func titleForSection(_ section: Int) -> String {
        if sectionsCount() <= section { return "" }
        return frc?.sections?[section].name ?? ""
    }
    
    public func itemsCount(in section: Int) -> Int {
        if sectionsCount() <= section { return 0 }
        return frc?.sections?[section].numberOfObjects ?? 0
    }
    
    public func item(at indexPath: IndexPath) -> Entity? {
        // Additional check to avoid exception when FRC has not fetched data yet
        if (frc?.fetchedObjects?.count == 0) {
            return nil
        }
        
        return frc?.object(at: indexPath)
    }

    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        contentChangedCallback?()
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        objectChangedCallback?(indexPath, type, newIndexPath)
    }

    public func itemsInSection(_ sectionIndex: Int) -> [Entity] {
        guard let sections = frc?.sections, sections.count > sectionIndex else { return [] }
        return sections[sectionIndex].objects as! [Entity]
    }
}

private extension CDPersistenceStoreAdapter {
    func buildFRC(with predicate: NSPredicate? = nil) {
        guard let store = store else { return }
        
        request.predicate = predicate
        frc = NSFetchedResultsController(fetchRequest: request,
                                         managedObjectContext: store.uiContext(),
                                         sectionNameKeyPath: sectionKeyPath,
                                         cacheName: nil)
        frc?.delegate = self
    }

    func fetch() {
        do { try frc?.performFetch() } catch {
            // Logger used to be here
            print("Failed to fetch FRC: \(String(describing: error))")
        }
    }
}
