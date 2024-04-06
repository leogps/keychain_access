//
//  KeychainAccessPlugin.swift
//  keychain_access
//
//  Created by Paul Gundarapu on 4/6/24.
//

#if os(OSX)
import Cocoa
import FlutterMacOS
#elseif os(iOS)
import UIKit
import Flutter
#endif

public class KeychainAccessPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel: FlutterMethodChannel
#if os(OSX)
        channel = FlutterMethodChannel(name: "keychain_access", binaryMessenger: registrar.messenger)
#elseif os(iOS)
        channel = FlutterMethodChannel(name: "keychain_access", binaryMessenger: registrar.messenger())
#endif
        let instance = KeychainAccessPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    private func handleAddSecureData(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.arguments == nil {
            result(FlutterError.init(code: "Invalid args", message: "AddSecureData requires args", details: nil))
            return
        }
        let req = KeychainAccessPlugin.parseCall(call)
        if req.key == nil {
            result(FlutterError.init(code: "Missing param", message: "AddSecureData requires key", details: nil))
            return
        }
        if req.value == nil {
            result(FlutterError.init(code: "Missing param", message: "AddSecureData requires value", details: nil))
            return
        }
        let status = KeychainAccess.addSecureData(service: req.application, account: req.key!, secureData: req.value!)
        if status == noErr {
            print("SecureData added successfully.")
            result("SUCCESS")
            return
        }
        let errorMessageFromStatus = SecCopyErrorMessageString(status, nil)
        let errorMessage = "Error adding SecureData. Status Code: \(status); Message: \(errorMessageFromStatus as Optional)"
        print(errorMessage)
        result(FlutterError.init(code: "Failed", message: errorMessage, details: nil))
    }
    
    private func handleUpdateSecureData(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.arguments == nil {
            result(FlutterError.init(code: "Invalid args", message: "UpdateSecureData requires args", details: nil))
            return
        }
        let req = KeychainAccessPlugin.parseCall(call)
        if req.key == nil {
            result(FlutterError.init(code: "Missing param", message: "UpdateSecureData requires key", details: nil))
            return
        }
        if req.value == nil {
            result(FlutterError.init(code: "Missing param", message: "UpdateSecureData requires value", details: nil))
            return
        }
        let status = KeychainAccess.updateSecureData(service: req.application, account: req.key!, secureData: req.value!)
        if status == noErr {
            print("SecureData updated successfully.")
            result("SUCCESS")
            return
        }
        let errorMessageFromStatus = SecCopyErrorMessageString(status, nil)
        let errorMessage = "Error updating SecureData. Status Code: \(status); Message: \(errorMessageFromStatus as Optional)"
        print(errorMessage)
        result(FlutterError.init(code: "Failed", message: errorMessage, details: nil))
    }
    
    private func handleAddOrUpdateSecureData(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.arguments == nil {
            result(FlutterError.init(code: "Invalid args", message: "AddOrUpdateSecureData requires args", details: nil))
            return
        }
        let req = KeychainAccessPlugin.parseCall(call)
        if req.key == nil {
            result(FlutterError.init(code: "Missing param", message: "AddOrUpdateSecureData requires key", details: nil))
            return
        }
        if req.value == nil {
            result(FlutterError.init(code: "Missing param", message: "AddOrUpdateSecureData requires value", details: nil))
            return
        }
        let secureDataResult = KeychainAccess.findSecureData(service: req.application, account: req.key!)
        if secureDataResult.0 == noErr {
            handleUpdateSecureData(call: call, result: result)
            return
        }
        handleAddSecureData(call: call, result: result)
    }
    
    private func handleFindSecureData(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.arguments == nil {
            result(FlutterError.init(code: "Invalid args", message: "FindSecureData requires args", details: nil))
            return
        }
        let req = KeychainAccessPlugin.parseCall(call)
        if req.key == nil {
            result(FlutterError.init(code: "Missing param", message: "FindSecureData requires key", details: nil))
            return
        }
        let secureDataResult = KeychainAccess.findSecureData(service: req.application, account: req.key!)
        let status = secureDataResult.0
        let secureDataValue = secureDataResult.1
        if status == noErr {
            print("SecureData retrieved successfully.")
            result(secureDataValue)
            return
        }
        if status == errSecItemNotFound {
            print("SecureData not found.")
            result(nil)
            return
        }
        let errorMessageFromStatus = SecCopyErrorMessageString(status, nil)
        let errorMessage = "Error retrieving SecureData. Status Code: \(status); Message: \(errorMessageFromStatus as Optional)"
        print(errorMessage)
        result(FlutterError.init(code: "Failed", message: errorMessage, details: nil))
    }
    
    private func hanldeDeleteSecureData(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.arguments == nil {
            result(FlutterError.init(code: "Invalid args", message: "DeleteSecureData requires args", details: nil))
            return
        }
        let req = KeychainAccessPlugin.parseCall(call)
        if req.key == nil {
            result(FlutterError.init(code: "Missing param", message: "DeleteSecureData requires key", details: nil))
            return
        }
        let status = KeychainAccess.deleteSecureData(service: req.application, account: req.key!)
        
        if status == noErr {
            print("SecureData deleted successfully.")
            result("SUCCESS")
            return
        }
        let errorMessageFromStatus = SecCopyErrorMessageString(status, nil)
        let errorMessage = "Error deleting SecureData. Status Code: \(status); Message: \(errorMessageFromStatus as Optional)"
        print(errorMessage)
        result(FlutterError.init(code: "Failed", message: errorMessage, details: nil))
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "addSecureData":
            handleAddSecureData(call: call, result: result)
            break
        case "updateSecureData":
            handleUpdateSecureData(call: call, result: result)
            break
        case "addOrUpdateSecureData":
            handleAddOrUpdateSecureData(call: call, result: result)
            break
        case "findSecureData":
            handleFindSecureData(call: call, result: result)
            break
        case "deleteSecureData":
            hanldeDeleteSecureData(call: call, result: result)
            break
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private static func parseCall(_ call: FlutterMethodCall) -> KeychainAccessRequest {
        let arguments = call.arguments as! [String : Any?]
        let application = arguments["application"] as? String
        let key = arguments["key"] as? String
        let value = arguments["value"] as? String
        
        return KeychainAccessRequest(
            application: application,
            key: key,
            value: value
        )
    }
    
    struct KeychainAccessRequest {
        var application: String?
        var key: String?
        var value: String?
    }
}
