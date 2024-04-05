import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keychain_access/keychain_access_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // MethodChannelKeychainAccess platform = MethodChannelKeychainAccess();
  const MethodChannel channel = MethodChannel('keychain_access');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });
}
