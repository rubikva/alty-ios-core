//
//  UserDefaultsProviderTests.swift
//  AltyCoreTests
//
//  Created by Deszip on 05.01.2020.
//  Copyright © 2020 Alty. All rights reserved.
//

import XCTest

@testable import AltyCore

import Nimble
import InstantMock

extension String: StorageKey {
    public var value: String {
        self
    }
}

class UserDefaultsProviderTests: XCTestCase {

    var defaults: UserDefaultsProvider?
    
    override func setUp() {
        self.defaults = UserDefaults.init(suiteName: "MockDefaults")
    }

    override func tearDown() {
        self.defaults = nil
    }

    func testProviderAssignsValue() {
        defaults?.setValue("Bar", forKey: "Baz")
        expect((self.defaults?.value(forKey: "Baz") as! String)).to(equal("Bar"))
    }
    
    func testProviderAssignsBool() {
        defaults?.setValue(true, forKey: "Baz")
        expect(self.defaults?.bool(forKey: "Baz")).to(beTrue())
    }
    
    func testProviderAssignsString() {
        defaults?.setValue("Bar", forKey: "Baz")
        expect(self.defaults?.string(forKey: "Baz")).to(equal("Bar"))
    }
    
    func testProviderAssignsURL() {
        let url = URL(string: "http://google.com")
        defaults?.setURL(url, forKey: "Baz")
        expect(self.defaults?.URL(forKey: "Baz")).to(equal(url))
    }

}
