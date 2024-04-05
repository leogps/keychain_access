
import 'keychain_access_platform_interface.dart';

class KeychainAccess {

  /// Add password with key and value(password).
  /// Optionally, specify application.
  Future<bool> addPassword(String key, String value, {
    String? application
  }) {
    return KeychainAccessPlatform.instance.addPassword(
        key,
        value,
        application: application
    );
  }

  /// Update password with key and value(password).
  /// Optionally, specify application.
  Future<bool> updatePassword(String key, String value, {
    String? application
  }) {
    return KeychainAccessPlatform.instance.updatePassword(
        key,
        value,
        application: application
    );
  }

  /// addOrUpdate password with key and value(password).
  /// Optionally, specify application.
  Future<bool> addOrUpdatePassword(String key, String value, {
    String? application
  }) {
    return KeychainAccessPlatform.instance.addOrUpdatePassword(
        key,
        value,
        application: application
    );
  }

  /// Find password for key.
  /// Optionally, specify application.
  Future<String?> findPassword(String key, {
    String? application
  }) {
    return KeychainAccessPlatform.instance.findPassword(
        key,
        application: application
    );
  }

  /// Delete password for key.
  /// Optionally, specify application.
  Future<bool> deletePassword(String key, {
    String? application
  }) {
    return KeychainAccessPlatform.instance.deletePassword(
        key,
        application: application
    );
  }
}
