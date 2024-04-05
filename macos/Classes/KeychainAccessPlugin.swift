import Cocoa
import FlutterMacOS

public class KeychainAccessPlugin: NSObject, FlutterPlugin {
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "keychain_access", binaryMessenger: registrar.messenger)
    let instance = KeychainAccessPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
    
    private func handleAddPassword(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.arguments == nil {
            result(FlutterError.init(code: "Invalid args", message: "addPassword requires args", details: nil))
            return
        }
        let req = KeychainAccessPlugin.parseCall(call)
        if req.key == nil {
            result(FlutterError.init(code: "Missing param", message: "addPassword requires key", details: nil))
            return
        }
        if req.value == nil {
            result(FlutterError.init(code: "Missing param", message: "addPassword requires value", details: nil))
            return
        }
        let status = KeychainAccess.addPassword(service: req.application, account: req.key!, password: req.value!)
        if status == noErr {
            print("Password added successfully.")
            result("SUCCESS")
            return
        }
        let errorMessageFromStatus = SecCopyErrorMessageString(status, nil)
        let errorMessage = "Error adding password. Status Code: \(status); Message: \(errorMessageFromStatus as Optional)"
        print(errorMessage)
        result(FlutterError.init(code: "Failed", message: errorMessage, details: nil))
    }
    
    private func handleUpdatePassword(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.arguments == nil {
            result(FlutterError.init(code: "Invalid args", message: "updatePassword requires args", details: nil))
            return
        }
        let req = KeychainAccessPlugin.parseCall(call)
        if req.key == nil {
            result(FlutterError.init(code: "Missing param", message: "updatePassword requires key", details: nil))
            return
        }
        if req.value == nil {
            result(FlutterError.init(code: "Missing param", message: "updatePassword requires value", details: nil))
            return
        }
        let status = KeychainAccess.updatePassword(service: req.application, account: req.key!, password: req.value!)
        if status == noErr {
            print("Password updated successfully.")
            result("SUCCESS")
            return
        }
        let errorMessageFromStatus = SecCopyErrorMessageString(status, nil)
        let errorMessage = "Error updating password. Status Code: \(status); Message: \(errorMessageFromStatus as Optional)"
        print(errorMessage)
        result(FlutterError.init(code: "Failed", message: errorMessage, details: nil))
    }
    
    private func handleAddOrUpdatePassword(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.arguments == nil {
            result(FlutterError.init(code: "Invalid args", message: "updatePassword requires args", details: nil))
            return
        }
        let req = KeychainAccessPlugin.parseCall(call)
        if req.key == nil {
            result(FlutterError.init(code: "Missing param", message: "updatePassword requires key", details: nil))
            return
        }
        if req.value == nil {
            result(FlutterError.init(code: "Missing param", message: "updatePassword requires value", details: nil))
            return
        }
        let passwordResult = KeychainAccess.findPassword(service: req.application, account: req.key!)
        if passwordResult.0 == noErr {
            handleUpdatePassword(call: call, result: result)
            return
        }
        handleAddPassword(call: call, result: result)
    }
    
    private func handleFindPassword(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.arguments == nil {
            result(FlutterError.init(code: "Invalid args", message: "findPassword requires args", details: nil))
            return
        }
        let req = KeychainAccessPlugin.parseCall(call)
        if req.key == nil {
            result(FlutterError.init(code: "Missing param", message: "findPassword requires key", details: nil))
            return
        }
        let passwordResult = KeychainAccess.findPassword(service: req.application, account: req.key!)
        let status = passwordResult.0
        let passwordValue = passwordResult.1
        if status == noErr {
            print("Password retrieved successfully.")
            result(passwordValue)
            return
        }
        if status == errSecItemNotFound {
            print("Password not found.")
            result(nil)
            return
        }
        let errorMessageFromStatus = SecCopyErrorMessageString(status, nil)
        let errorMessage = "Error retrieving password. Status Code: \(status); Message: \(errorMessageFromStatus as Optional)"
        print(errorMessage)
        result(FlutterError.init(code: "Failed", message: errorMessage, details: nil))
    }
    
    private func handleDeletePassword(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.arguments == nil {
            result(FlutterError.init(code: "Invalid args", message: "deletePassword requires args", details: nil))
            return
        }
        let req = KeychainAccessPlugin.parseCall(call)
        if req.key == nil {
            result(FlutterError.init(code: "Missing param", message: "deletePassword requires key", details: nil))
            return
        }
        let status = KeychainAccess.deletePassword(service: req.application, account: req.key!)
        
        if status == noErr {
            print("Password deleted successfully.")
            result("SUCCESS")
            return
        }
        let errorMessageFromStatus = SecCopyErrorMessageString(status, nil)
        let errorMessage = "Error deleting password. Status Code: \(status); Message: \(errorMessageFromStatus as Optional)"
        print(errorMessage)
        result(FlutterError.init(code: "Failed", message: errorMessage, details: nil))
    }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "addPassword":
        handleAddPassword(call: call, result: result)
        break
    case "updatePassword":
        handleUpdatePassword(call: call, result: result)
        break
    case "addOrUpdatePassword":
        handleAddOrUpdatePassword(call: call, result: result)
        break
    case "findPassword":
        handleFindPassword(call: call, result: result)
        break
    case "deletePassword":
        handleDeletePassword(call: call, result: result)
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
