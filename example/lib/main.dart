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

  Future<void> _triggerAddPassword(_PluginFunctionResults results,
      {String? application}) async {
    String passwordAddSuccessful;
    try {
      passwordAddSuccessful = await _keychainAccessPlugin.addSecureData(
              exampleUsername, examplePassword,
              application: application)
          ? "Success"
          : "FAILED";
    } on PlatformException catch (e) {
      passwordAddSuccessful = 'Failed to addPassword $e';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      results.addPasswordStatus.message = passwordAddSuccessful;
      results.addPasswordStatus.status = passwordAddSuccessful == "Success";
    });
  }

  Future<void> _triggerUpdatePassword(_PluginFunctionResults results,
      {String? application}) async {
    String passwordUpdateSuccessful;
    try {
      passwordUpdateSuccessful = await _keychainAccessPlugin.updateSecureData(
              exampleUsername, exampleUpdatedPassword,
              application: application)
          ? "Success"
          : "FAILED";
    } on PlatformException catch (e) {
      passwordUpdateSuccessful = 'Failed to updatePassword $e';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      results.updatePasswordStatus.message = passwordUpdateSuccessful;
      results.updatePasswordStatus.status =
          passwordUpdateSuccessful == 'Success';
    });
  }

  Future<void> _triggerAddOrUpdatePassword(_PluginFunctionResults results,
      {String? application}) async {
    String addOrUpdatePasswordSuccessful;
    try {
      addOrUpdatePasswordSuccessful = await _keychainAccessPlugin
              .updateSecureData(exampleUsername, exampleAddOrUpdatePassword,
                  application: application)
          ? "Success"
          : "FAILED";
    } on PlatformException catch (e) {
      addOrUpdatePasswordSuccessful = 'Failed to addOrUpdatePassword $e';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      results.addOrUpdatePasswordStatus.message = addOrUpdatePasswordSuccessful;
      results.addOrUpdatePasswordStatus.status =
          addOrUpdatePasswordSuccessful == 'Success';
    });
  }

  Future<void> _triggerFindPassword(
      _PluginFunctionResults results, String? expected,
      {String? application, String? key}) async {
    String findPasswordSuccessful;
    bool isSuccess = false;
    try {
      key ??= exampleUsername;
      final passwordValue = await _keychainAccessPlugin.findSecureData(key,
          application: application);
      isSuccess = passwordValue == expected;
      findPasswordSuccessful =
          isSuccess ? "$passwordValue" : "Failed";
    } on PlatformException catch (e) {
      findPasswordSuccessful = 'Failed to findPassword $e';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      final result = _PluginFunctionResult();
      result.message = findPasswordSuccessful;
      result.status = isSuccess;
      results.findPasswordStatuses.add(result);
    });
  }

  Future<void> _triggerDeletePassword(_PluginFunctionResults results,
      {String? application}) async {
    String deletePasswordSuccessful;
    try {
      deletePasswordSuccessful = await _keychainAccessPlugin
              .deleteSecureData(exampleUsername, application: application)
          ? "Success"
          : "Failed";
    } on PlatformException catch (e) {
      deletePasswordSuccessful = 'Failed to deletePassword $e';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      results.deletePasswordStatus.message = deletePasswordSuccessful;
      results.deletePasswordStatus.status =
          deletePasswordSuccessful == 'Success';
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
    await _triggerFindPassword(_simpleResults, null, key: "DOES_NOT_EXIST");

    // Results for Application name.
    await _triggerAddPassword(_resultsForApplicationName,
        application: applicationName);
    await _triggerFindPassword(_resultsForApplicationName, examplePassword,
        application: applicationName);

    await _triggerUpdatePassword(_resultsForApplicationName,
        application: applicationName);
    await _triggerFindPassword(
        _resultsForApplicationName, exampleUpdatedPassword,
        application: applicationName);

    await _triggerAddOrUpdatePassword(_resultsForApplicationName,
        application: applicationName);
    await _triggerFindPassword(
        _resultsForApplicationName, exampleAddOrUpdatePassword,
        application: applicationName);

    await _triggerDeletePassword(_resultsForApplicationName,
        application: applicationName);
    await _triggerFindPassword(_resultsForApplicationName, null,
        application: applicationName, key: "DOES_NOT_EXIST");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Keychain Access Plugin Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Table(
            border: TableBorder.all(),
            // columnWidths: {
            //   0: FixedColumnWidth(400),
            //   1: FixedColumnWidth(400),
            // },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  TableCell(child: columnField('Function Name', heading: true)),
                  TableCell(
                    child: columnField('No Application field', heading: true),
                  ),
                  TableCell(
                    child: columnField('W/ Application', heading: true),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: columnField('addSecureData'),
                  ),
                  TableCell(
                    child: columnField(_buildStatusMessage(
                        [_simpleResults.addPasswordStatus])),
                  ),
                  TableCell(
                    child: columnField(_buildStatusMessage(
                        [_resultsForApplicationName.addPasswordStatus])),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: columnField('updateSecureData'),
                  ),
                  TableCell(
                    child: columnField(_buildStatusMessage(
                        [_simpleResults.updatePasswordStatus])),
                  ),
                  TableCell(
                    child: columnField(_buildStatusMessage(
                        [_resultsForApplicationName.updatePasswordStatus])),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: columnField('addOrUpdateSecureData'),
                  ),
                  TableCell(
                    child: columnField(_buildStatusMessage(
                        [_simpleResults.addOrUpdatePasswordStatus])),
                  ),
                  TableCell(
                    child: columnField(_buildStatusMessage([
                      _resultsForApplicationName.addOrUpdatePasswordStatus
                    ])),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: columnField('findSecureData'),
                  ),
                  TableCell(
                    child: columnField(_buildStatusMessage(
                        _simpleResults.findPasswordStatuses)),
                  ),
                  TableCell(
                    child: columnField(_buildStatusMessage(
                        _resultsForApplicationName.findPasswordStatuses)),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: columnField('deleteSecureData'),
                  ),
                  TableCell(
                    child: columnField(_buildStatusMessage(
                        [_simpleResults.deletePasswordStatus])),
                  ),
                  TableCell(
                    child: columnField(_buildStatusMessage(
                        [_resultsForApplicationName.deletePasswordStatus])),
                  ),
                ],
              ),
            ]),
      ),
    ));
  }

  Widget columnField(String text, {bool heading = false}) {
    TextStyle style = const TextStyle();
    if (heading) {
      style = const TextStyle(fontWeight: FontWeight.bold);
    }
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(
        text,
        style: style,
      ),
    );
  }

  String _buildStatusMessage(List<_PluginFunctionResult> statuses) {
    if (statuses.isEmpty) {
      return '';
    }
    bool allSuccess = statuses
        .map((e) => e.status)
        .reduce((value, element) => value && element);
    final message = statuses.map((e) => e.message).join('\n');
    if (allSuccess) {
      return '✅$message';
    }
    return '❌$message';
  }
}

class _PluginFunctionResults {
  _PluginFunctionResult addPasswordStatus = _PluginFunctionResult();
  _PluginFunctionResult updatePasswordStatus = _PluginFunctionResult();
  _PluginFunctionResult addOrUpdatePasswordStatus = _PluginFunctionResult();
  final List<_PluginFunctionResult> findPasswordStatuses = [];
  _PluginFunctionResult deletePasswordStatus = _PluginFunctionResult();
}

class _PluginFunctionResult {
  bool status = false;
  String message = 'Unknown';
}
