//
//  UserDefaultsProvider.swift
//  cbh-cards-ios
//
//  Created by Deszip on 09/09/2019.
//  Copyright © 2019 Alty. All rights reserved.
//

import Foundation
   
public protocol UserDefaultsProvider {
	func bool(forKey defaultName: StorageKey) -> Bool
    func string(forKey defaultName: StorageKey) -> String?
    func URL(forKey defaultName: StorageKey) -> URL?
    
    func setURL(_ url: URL?, forKey defaultName: StorageKey)
    func setValue(_ value: Any?, forKey defaultName: StorageKey)
    func value(forKey key: String) -> Any?
}

extension UserDefaults: UserDefaultsProvider {
    
    public func setValue(_ value: Any?, forKey defaultName: StorageKey) {
        self.set(value, forKey: defaultName.value)
    }
    
    public func bool(forKey defaultName: StorageKey) -> Bool {
        return self.bool(forKey: defaultName.value)
    }
    
    public func string(forKey defaultName: StorageKey) -> String? {
        return self.string(forKey: defaultName.value)
    }
    
    public func URL(forKey defaultName: StorageKey) -> URL? {
        return self.url(forKey: defaultName.value)
    }
    
    public func setURL(_ url: URL?, forKey defaultName: StorageKey) {
        self.set(url, forKey: defaultName.value)
    }
}
