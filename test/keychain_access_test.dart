import 'package:flutter_test/flutter_test.dart';
import 'package:keychain_access/keychain_access.dart';
import 'package:keychain_access/keychain_access_platform_interface.dart';
import 'package:keychain_access/keychain_access_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockKeychainAccessPlatform
    with MockPlatformInterfaceMixin
    implements KeychainAccessPlatform {

  @override
  Future<bool> addPassword(String key, String value, {
    String? application
  }) => Future.value(true);

  @override
  Future<bool> updatePassword(String key, String value, {
    String? application
  }) => Future.value(true);

  @override
  Future<bool> addOrUpdatePassword(String key, String value, {
    String? application
  }) => Future.value(true);

  @override
  Future<String?> findPassword(String key, {
    String? application
  }) => Future.value("My_Password");

  @override
  Future<bool> deletePassword(String key, {
    String? application
  }) => Future.value(true);
}

void main() {
  final KeychainAccessPlatform initialPlatform = KeychainAccessPlatform.instance;

  test('$MethodChannelKeychainAccess is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelKeychainAccess>());
  });

  test('addPassword', () async {
    KeychainAccess keychainAccessPlugin = KeychainAccess();
    MockKeychainAccessPlatform fakePlatform = MockKeychainAccessPlatform();
    KeychainAccessPlatform.instance = fakePlatform;

    expect(await keychainAccessPlugin.addPassword('my_app', 'my_password'), true);
  });

  test('updatePassword', () async {
    KeychainAccess keychainAccessPlugin = KeychainAccess();
    MockKeychainAccessPlatform fakePlatform = MockKeychainAccessPlatform();
    KeychainAccessPlatform.instance = fakePlatform;

    expect(await keychainAccessPlugin.updatePassword('my_app', 'my_password'), true);
  });

  test('addOrUpdatePassword', () async {
    KeychainAccess keychainAccessPlugin = KeychainAccess();
    MockKeychainAccessPlatform fakePlatform = MockKeychainAccessPlatform();
    KeychainAccessPlatform.instance = fakePlatform;

    expect(await keychainAccessPlugin.addOrUpdatePassword('my_app', 'my_password'), true);
  });

  test('findPassword', () async {
    KeychainAccess keychainAccessPlugin = KeychainAccess();
    MockKeychainAccessPlatform fakePlatform = MockKeychainAccessPlatform();
    KeychainAccessPlatform.instance = fakePlatform;

    expect(await keychainAccessPlugin.findPassword('my_app'), 'My_Password');
  });

  test('deletePassword', () async {
    KeychainAccess keychainAccessPlugin = KeychainAccess();
    MockKeychainAccessPlatform fakePlatform = MockKeychainAccessPlatform();
    KeychainAccessPlatform.instance = fakePlatform;

    expect(await keychainAccessPlugin.deletePassword('my_app'), true);
  });
}
