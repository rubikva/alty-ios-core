//
//  SecureStorageProvider.swift
//  CBHCards
//
//  Created by Deszip on 27.11.2019.
//  Copyright © 2019 Alty. All rights reserved.
//

import KeychainAccess
 
public protocol SecureStorageProvider {
    func getData(for key: StorageKey) -> Data?
    func set(_ data: Data, for key: StorageKey)
    
    func getString(for key: StorageKey) -> String?
    func set(_ string: String?, for key: StorageKey)
    
    func getURL(for key: StorageKey) -> URL?
    func set(_ url: URL?, for key: StorageKey)
}

extension Keychain: SecureStorageProvider {
    
    public func getData(for key: StorageKey) -> Data? {
        let data = self[data: key.value]
        if data?.count == 0 { return nil }
        return data
    }
    
    public func set(_ data: Data, for key: StorageKey) {
        self[data: key.value] = data
    }
    
    public func getString(for key: StorageKey) -> String? {
        guard let data = getData(for: key) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    public func set(_ string: String?, for key: StorageKey) {
        set(string?.data(using: .utf8) ?? Data(), for: key)
    }
    
    public func getURL(for key: StorageKey) -> URL? {
        guard let data = getData(for: key) else { return nil }
        return URL(dataRepresentation: data, relativeTo: nil)
    }
    
    public func set(_ url: URL?, for key: StorageKey) {
        set(url?.dataRepresentation ?? Data(), for: key)
    }
    
}
