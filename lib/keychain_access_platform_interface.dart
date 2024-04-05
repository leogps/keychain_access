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

  Future<bool> addSecureData(String key, String value, {
    String? application
  }) {
    throw UnimplementedError('addSecureData() has not been implemented.');
  }

  Future<bool> updateSecureData(String key, String value, {
    String? application
  }) {
    throw UnimplementedError('updateSecureData() has not been implemented.');
  }

  Future<bool> addOrUpdateSecureData(String key, String value, {
    String? application
  }) {
    throw UnimplementedError('addOrUpdateSecureData() has not been implemented.');
  }

  Future<String?> findSecureData(String key, {
    String? application
  }) {
    throw UnimplementedError('findSecureData() has not been implemented.');
  }

  Future<bool> deleteSecureData(String key, {
    String? application
  }) {
    throw UnimplementedError('deleteSecureData() has not been implemented.');
  }
}
