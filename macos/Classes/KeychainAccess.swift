//
//  KeychainAccess.swift
//  keychain_access
//
//  Created by Paul Gundarapu on 4/4/24.
//

import Foundation
import Security

class KeychainAccess {
    // Function to add secure data to the keychain
    static func addSecureData(service:String?, account: String, secureData: String) -> OSStatus {
        let query = NSMutableDictionary()
        query[kSecClass] = kSecClassGenericPassword
        query[kSecAttrAccount] = account
        query[kSecValueData] = Data(secureData.utf8)
        if service != nil {
            query[kSecAttrService] = service
        }

        return SecItemAdd(query, nil)
    }


    // Function to update the secure data in the keychain using the key (#account)
    static func updateSecureData(service:String?, account: String, secureData: String) -> OSStatus {
        let query = NSMutableDictionary()
        query[kSecClass] = kSecClassGenericPassword
        query[kSecAttrAccount] = account
        if service != nil {
            query[kSecAttrService] = service
        }

        let attributesToUpdate = [
            kSecValueData: Data(secureData.utf8)
        ] as CFDictionary

        return SecItemUpdate(query, attributesToUpdate)
    }

    // Function to find secure data in the keychain
    static func findSecureData(service: String?, account: String) -> (OSStatus, String?) {
        let query = NSMutableDictionary()
        query[kSecClass] = kSecClassGenericPassword
        query[kSecAttrAccount] = account
        query[kSecMatchLimit] = kSecMatchLimitOne
        query[kSecReturnData] = kCFBooleanTrue as Any

        if service != nil {
            query[kSecAttrService] = service
        }

        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)

        guard status == noErr, let data = result as? Data else {
            return (status, nil)
        }

        return (status, String(data: data, encoding: .utf8))
    }

    // Function to delete secure data from the keychain
    static func deleteSecureData(service: String?, account: String) -> OSStatus {
        let query = NSMutableDictionary()
        query[kSecClass] = kSecClassGenericPassword
        query[kSecAttrAccount] = account

        if service != nil {
            query[kSecAttrService] = service
        }

        return SecItemDelete(query)
    }
}
