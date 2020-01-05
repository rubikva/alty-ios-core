//
//  CDPersistenceStoreTests.swift
//  AltyCoreTests
//
//  Created by Deszip on 05.01.2020.
//  Copyright © 2020 Alty. All rights reserved.
//

import XCTest
import Nimble
import InstantMock

@testable import AltyCore
import CoreData

class CDPersistenceStoreTests: XCTestCase {

    var store: CDPersistenceStoreImpl!
    
    override func setUp() {
        store = CDPersistenceStoreImpl(storeName: "mock-model", bundle: Bundle(for: CDPersistenceStoreTests.self), storeType: NSInMemoryStoreType)
    }

    override func tearDown() {
        store = nil
    }

    func testStoreBuildsUIContext() {
        let context = store.uiContext()
        
        expect(context.automaticallyMergesChangesFromParent).to(beTrue())
        expect(context.concurrencyType).to(equal(.mainQueueConcurrencyType))
    }
    
    func testStoreReturnsSameUIContext() {
        let context_1 = store.uiContext()
        let context_2 = store.uiContext()
        
        expect(context_1).to(equal(context_2))
    }
    
    func testStoreBuildsBackgroundContext() {
        let context = store.backgroundContext()
        
        expect(context.automaticallyMergesChangesFromParent).to(beTrue())
        expect(context.concurrencyType).to(equal(.privateQueueConcurrencyType))
    }

    func testStoreBuildsNewBackgroundContext() {
        let context_1 = store.backgroundContext()
        let context_2 = store.backgroundContext()
        
        expect(context_1).toNot(equal(context_2))
    }
    
}
