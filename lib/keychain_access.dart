import 'keychain_access_platform_interface.dart';

class KeychainAccess {
  /// Add secure data with key and value(password).
  /// Note*: Throws exception if a record with key exists.
  /// Optionally, specify application.
  Future<bool> addSecureData(String key, String value, {String? application}) {
    return KeychainAccessPlatform.instance
        .addSecureData(key, value, application: application);
  }

  /// Update secure data with key and value(password).
  /// Note*: Throws exception if a record with key does not exist.
  /// Optionally, specify application.
  Future<bool> updateSecureData(String key, String value,
      {String? application}) {
    return KeychainAccessPlatform.instance
        .updateSecureData(key, value, application: application);
  }

  /// addOrUpdate secure data with key and value(password).
  /// Essentially, does not throw any exception if data does not exist with the
  /// key and adds the secure data to the keychain, if found, it replaces the
  /// existing record.
  /// Optionally, specify application.
  Future<bool> addOrUpdateSecureData(String key, String value,
      {String? application}) {
    return KeychainAccessPlatform.instance
        .addOrUpdateSecureData(key, value, application: application);
  }

  /// Find secure data with key in the keychain.
  /// Returns null if not found.
  /// Optionally, specify application.
  Future<String?> findSecureData(String key, {String? application}) {
    return KeychainAccessPlatform.instance
        .findSecureData(key, application: application);
  }

  /// Delete secure data for key.
  /// Optionally, specify application.
  Future<bool> deleteSecureData(String key, {String? application}) {
    return KeychainAccessPlatform.instance
        .deleteSecureData(key, application: application);
  }
}
