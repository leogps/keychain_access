import 'package:flutter_test/flutter_test.dart';
import 'package:keychain_access/keychain_access.dart';
import 'package:keychain_access/keychain_access_platform_interface.dart';
import 'package:keychain_access/keychain_access_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockKeychainAccessPlatform
    with MockPlatformInterfaceMixin
    implements KeychainAccessPlatform {

  @override
  Future<bool> addSecureData(String key, String value, {
    String? application
  }) => Future.value(true);

  @override
  Future<bool> updateSecureData(String key, String value, {
    String? application
  }) => Future.value(true);

  @override
  Future<bool> addOrUpdateSecureData(String key, String value, {
    String? application
  }) => Future.value(true);

  @override
  Future<String?> findSecureData(String key, {
    String? application
  }) => Future.value("My_Password");

  @override
  Future<bool> deleteSecureData(String key, {
    String? application
  }) => Future.value(true);
}

void main() {
  final KeychainAccessPlatform initialPlatform = KeychainAccessPlatform.instance;

  test('$MethodChannelKeychainAccess is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelKeychainAccess>());
  });

  test('addSecureData', () async {
    KeychainAccess keychainAccessPlugin = KeychainAccess();
    MockKeychainAccessPlatform fakePlatform = MockKeychainAccessPlatform();
    KeychainAccessPlatform.instance = fakePlatform;

    expect(await keychainAccessPlugin.addSecureData('my_app', 'my_password'), true);
  });

  test('updateSecureData', () async {
    KeychainAccess keychainAccessPlugin = KeychainAccess();
    MockKeychainAccessPlatform fakePlatform = MockKeychainAccessPlatform();
    KeychainAccessPlatform.instance = fakePlatform;

    expect(await keychainAccessPlugin.updateSecureData('my_app', 'my_password'), true);
  });

  test('addOrUpdateSecureData', () async {
    KeychainAccess keychainAccessPlugin = KeychainAccess();
    MockKeychainAccessPlatform fakePlatform = MockKeychainAccessPlatform();
    KeychainAccessPlatform.instance = fakePlatform;

    expect(await keychainAccessPlugin.addOrUpdateSecureData('my_app', 'my_password'), true);
  });

  test('findSecureData', () async {
    KeychainAccess keychainAccessPlugin = KeychainAccess();
    MockKeychainAccessPlatform fakePlatform = MockKeychainAccessPlatform();
    KeychainAccessPlatform.instance = fakePlatform;

    expect(await keychainAccessPlugin.findSecureData('my_app'), 'My_Password');
  });

  test('deleteSecureData', () async {
    KeychainAccess keychainAccessPlugin = KeychainAccess();
    MockKeychainAccessPlatform fakePlatform = MockKeychainAccessPlatform();
    KeychainAccessPlatform.instance = fakePlatform;

    expect(await keychainAccessPlugin.deleteSecureData('my_app'), true);
  });
}
