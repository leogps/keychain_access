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
  Future<bool> addPassword(String key, String value, {
    String? application
  }) async {
    final result = await methodChannel.invokeMethod<String>('addPassword', {
      'application': application,
      'key': key,
      'value': value
    });
    return result == success;
  }

  @override
  Future<bool> updatePassword(String key, String value, {
    String? application
  }) async {
    final result = await methodChannel.invokeMethod<String>('updatePassword', {
      'application': application,
      'key': key,
      'value': value
    });
    return result == success;
  }

  @override
  Future<bool> addOrUpdatePassword(String key, String value, {
    String? application
  }) async {
    final result = await methodChannel.invokeMethod<String>('addOrUpdatePassword', {
      'application': application,
      'key': key,
      'value': value
    });
    return result == success;
  }

  @override
  Future<String?> findPassword(String key, {
    String? application
  }) async {
    return await methodChannel.invokeMethod<String>('findPassword', {
      'application': application,
      'key': key
    });
  }

  @override
  Future<bool> deletePassword(String key, {
    String? application
  }) async {
    final result = await methodChannel.invokeMethod<String>('deletePassword', {
      'application': application,
      'key': key
    });
    return result == success;
  }
}
