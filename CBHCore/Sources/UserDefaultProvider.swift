    //
//  RootModuleInteractor.swift
//  cbh-cards-ios
//
//  Created by Deszip on 09/09/2019.
//  Copyright © 2019 Alty. All rights reserved.
//

import Foundation

protocol UserDefaultsProvider {
	func bool(forKey defaultName: StorageKey) -> Bool
    func string(forKey defaultName: StorageKey) -> String?
    func URL(forKey defaultName: StorageKey) -> URL?
    
    func setURL(_ url: URL?, forKey defaultName: StorageKey)
    func set(_ value: Any?, forKey defaultName: StorageKey)
    func value(forKey key: String) -> Any?
}

extension UserDefaults: UserDefaultsProvider {
    
    func set(_ value: Any?, forKey defaultName: StorageKey) {
        self.set(value, forKey: defaultName)
    }
    
    func bool(forKey defaultName: StorageKey) -> Bool {
        return self.bool(forKey: defaultName)
    }
    
    func string(forKey defaultName: StorageKey) -> String? {
        return self.string(forKey: defaultName)
    }
    
    func URL(forKey defaultName: StorageKey) -> URL? {
        return self.url(forKey: defaultName)
    }
    
    func setURL(_ url: URL?, forKey defaultName: StorageKey) {
        self.set(url, forKey: defaultName)
    }
}
