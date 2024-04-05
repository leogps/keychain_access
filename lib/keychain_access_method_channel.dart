import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'keychain_access_platform_interface.dart';

const success = "SUCCESS";

/// An implementation of [KeychainAccessPlatform] that uses method channels.
class MethodChannelKeychainAccess extends KeychainAccessPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('keychain_access');

  @override
  Future<bool> addSecureData(String key, String value,
      {String? application}) async {
    final result = await methodChannel.invokeMethod<String>('addSecureData',
        {'application': application, 'key': key, 'value': value});
    return result == success;
  }

  @override
  Future<bool> updateSecureData(String key, String value,
      {String? application}) async {
    final result = await methodChannel.invokeMethod<String>('updateSecureData',
        {'application': application, 'key': key, 'value': value});
    return result == success;
  }

  @override
  Future<bool> addOrUpdateSecureData(String key, String value,
      {String? application}) async {
    final result = await methodChannel.invokeMethod<String>(
        'addOrUpdateSecureData',
        {'application': application, 'key': key, 'value': value});
    return result == success;
  }

  @override
  Future<String?> findSecureData(String key, {String? application}) async {
    return await methodChannel.invokeMethod<String>(
        'findSecureData', {'application': application, 'key': key});
  }

  @override
  Future<bool> deleteSecureData(String key, {String? application}) async {
    final result = await methodChannel.invokeMethod<String>(
        'deleteSecureData', {'application': application, 'key': key});
    return result == success;
  }
}
