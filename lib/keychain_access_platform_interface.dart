import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'keychain_access_method_channel.dart';

abstract class KeychainAccessPlatform extends PlatformInterface {
  /// Constructs a KeychainAccessPlatform.
  KeychainAccessPlatform() : super(token: _token);

  static final Object _token = Object();

  static KeychainAccessPlatform _instance = MethodChannelKeychainAccess();

  /// The default instance of [KeychainAccessPlatform] to use.
  ///
  /// Defaults to [MethodChannelKeychainAccess].
  static KeychainAccessPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [KeychainAccessPlatform] when
  /// they register themselves.
  static set instance(KeychainAccessPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> addPassword(String key, String value, {
    String? application
  }) {
    throw UnimplementedError('addPassword() has not been implemented.');
  }

  Future<bool> updatePassword(String key, String value, {
    String? application
  }) {
    throw UnimplementedError('updatePassword() has not been implemented.');
  }

  Future<bool> addOrUpdatePassword(String key, String value, {
    String? application
  }) {
    throw UnimplementedError('addOrUpdatePassword() has not been implemented.');
  }

  Future<String?> findPassword(String key, {
    String? application
  }) {
    throw UnimplementedError('findPassword() has not been implemented.');
  }

  Future<bool> deletePassword(String key, {
    String? application
  }) {
    throw UnimplementedError('deletePassword() has not been implemented.');
  }
}
