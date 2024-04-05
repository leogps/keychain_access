//
//  KeychainAccess.swift
//  keychain_access
//
//  Created by Paul Gundarapu on 4/4/24.
//

import Foundation
import Security

class KeychainAccess {
    // Function to add a password to the keychain
    static func addPassword(service:String?, account: String, password: String) -> OSStatus {
        let query = NSMutableDictionary()
        query[kSecClass] = kSecClassGenericPassword
        query[kSecAttrAccount] = account
        query[kSecValueData] = Data(password.utf8)
        if service != nil {
            query[kSecAttrService] = service
        }
        
        return SecItemAdd(query, nil)
    }
    
    
    // Function to update the password to the keychain
    static func updatePassword(service:String?, account: String, password: String) -> OSStatus {
        let query = NSMutableDictionary()
        query[kSecClass] = kSecClassGenericPassword
        query[kSecAttrAccount] = account
        if service != nil {
            query[kSecAttrService] = service
        }
        
        let attributesToUpdate = [
            kSecValueData: Data(password.utf8)
        ] as CFDictionary
        
        return SecItemUpdate(query, attributesToUpdate)
    }

    // Function to find a password in the keychain
    static func findPassword(service: String?, account: String) -> (OSStatus, String?) {
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

    // Function to delete a password from the keychain
    static func deletePassword(service: String?, account: String) -> OSStatus {
        let query = NSMutableDictionary()
        query[kSecClass] = kSecClassGenericPassword
        query[kSecAttrAccount] = account
        
        if service != nil {
            query[kSecAttrService] = service
        }
        
        return SecItemDelete(query)
    }
}
