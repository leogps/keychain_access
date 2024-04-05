import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:keychain_access/keychain_access.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _simpleResults = _PluginFunctionResults();
  final _resultsForApplicationName = _PluginFunctionResults();
  final _keychainAccessPlugin = KeychainAccess();

  final applicationName = 'org.gps.flutterKeychainAccessPlugin';
  final exampleUsername = 'username123';
  final examplePassword = 'password123';
  final exampleUpdatedPassword = 'updatedPassword123';
  final exampleAddOrUpdatePassword = 'addOrUpdatePassword123';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> _triggerAddPassword(_PluginFunctionResults results, {
    String? application
  }) async {
    String passwordAddSuccessful;
    try {
      passwordAddSuccessful =
      await _keychainAccessPlugin.addPassword(
        exampleUsername,
        examplePassword,
          application: application
      ) ?
      "Success" : "FAILED";
    } on PlatformException catch(e) {
      passwordAddSuccessful = 'Failed to addPassword $e';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      results.addPasswordStatus = passwordAddSuccessful;
    });
  }

  Future<void> _triggerUpdatePassword(_PluginFunctionResults results, {
    String? application
  }) async {
    String passwordUpdateSuccessful;
    try {
      passwordUpdateSuccessful = await _keychainAccessPlugin.updatePassword(
        exampleUsername,
        exampleUpdatedPassword,
        application: application
      ) ?
      "Success" : "FAILED";
    } on PlatformException catch(e) {
      passwordUpdateSuccessful = 'Failed to updatePassword $e';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      results.updatePasswordStatus = passwordUpdateSuccessful;
    });
  }

  Future<void> _triggerAddOrUpdatePassword(_PluginFunctionResults results, {
    String? application
  }) async {
    String addOrUpdatePasswordSuccessful;
    try {
      addOrUpdatePasswordSuccessful =
      await _keychainAccessPlugin.updatePassword(
        exampleUsername,
        exampleAddOrUpdatePassword,
        application: application
      ) ?
      "Success" : "FAILED";
    } on PlatformException catch(e) {
      addOrUpdatePasswordSuccessful = 'Failed to addOrUpdatePassword $e';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      results.addOrUpdatePasswordStatus = addOrUpdatePasswordSuccessful;
    });
  }

  Future<void> _triggerFindPassword(_PluginFunctionResults results, String expected,
  {
    String? application
  }) async {
    String findPasswordSuccessful;
    try {
      final passwordValue = await _keychainAccessPlugin.findPassword(
            exampleUsername,
            application: application
        );
      findPasswordSuccessful = passwordValue == expected
          ? "Success($passwordValue)": "Failed";
    } on PlatformException catch(e) {
      findPasswordSuccessful = 'Failed to findPassword $e';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      results.findPasswordStatuses.add(findPasswordSuccessful);
    });
  }

  Future<void> _triggerDeletePassword(_PluginFunctionResults results, {
    String? application
  }) async {
    String deletePasswordSuccessful;
    try {
      deletePasswordSuccessful = await _keychainAccessPlugin.deletePassword(
          exampleUsername,
          application: application
      )
          ? "Success": "Failed";
    } on PlatformException catch(e) {
      deletePasswordSuccessful = 'Failed to deletePassword $e';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      results.deletePasswordStatus = deletePasswordSuccessful;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Simple Results.
    await _triggerAddPassword(_simpleResults);
    await _triggerFindPassword(_simpleResults, examplePassword);

    await _triggerUpdatePassword(_simpleResults);
    await _triggerFindPassword(_simpleResults, exampleUpdatedPassword);

    await _triggerAddOrUpdatePassword(_simpleResults);
    await _triggerFindPassword(_simpleResults, exampleAddOrUpdatePassword);

    await _triggerDeletePassword(_simpleResults);

    // Results for Application name.
    await _triggerAddPassword(
      _resultsForApplicationName,
      application: applicationName
    );
    await _triggerFindPassword(
      _resultsForApplicationName,
      examplePassword,
      application: applicationName
    );

    await _triggerUpdatePassword(
      _resultsForApplicationName,
      application: applicationName
    );
    await _triggerFindPassword(
      _resultsForApplicationName,
      exampleUpdatedPassword,
      application: applicationName
    );

    await _triggerAddOrUpdatePassword(
      _resultsForApplicationName,
      application: applicationName
    );
    await _triggerFindPassword(
      _resultsForApplicationName,
      exampleAddOrUpdatePassword,
      application: applicationName
    );

    await _triggerDeletePassword(
      _resultsForApplicationName,
      application: applicationName
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Keychain Access Plugin Example'),
        ),
        body: Column(
          children: [
            const Divider(),
            const Center(
              child: Text('Simple password tests:'),
            ),
            const Divider(),
            Center(
              child: Text('Add Password Status: ${_simpleResults.addPasswordStatus}\n'),
            ),
            Center(
              child: Text('Update Password Status: ${_simpleResults.updatePasswordStatus}\n'),
            ),
            Center(
              child: Text('Update Password Status: ${_simpleResults.addOrUpdatePasswordStatus}\n'),
            ),
            Center(
              child: Text('Find Password Statuses: ${_simpleResults.findPasswordStatuses}\n'),
            ),
            Center(
              child: Text('Delete Password Status: ${_simpleResults.deletePasswordStatus}\n'),
            ),
            const Divider(),

            Center(
              child: Text('Application password tests for application: $applicationName'),
            ),
            const Divider(),
            Center(
              child: Text('Add Password Status: ${_resultsForApplicationName.addPasswordStatus}\n'),
            ),
            Center(
              child: Text('Update Password Status: ${_resultsForApplicationName.updatePasswordStatus}\n'),
            ),
            Center(
              child: Text('Update Password Status: ${_resultsForApplicationName.addOrUpdatePasswordStatus}\n'),
            ),
            Center(
              child: Text('Find Password Statuses: ${_resultsForApplicationName.findPasswordStatuses}\n'),
            ),
            Center(
              child: Text('Delete Password Status: ${_resultsForApplicationName.deletePasswordStatus}\n'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PluginFunctionResults {
  String addPasswordStatus = 'Unknown';
  String updatePasswordStatus = 'Unknown';
  String addOrUpdatePasswordStatus = 'Unknown';
  final findPasswordStatuses = [];
  String deletePasswordStatus = 'Unknown';
}
