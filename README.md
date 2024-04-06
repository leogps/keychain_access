# keychain_access

Flutter plugin to access Keychain Access apis on MacOS & iOS.

- Following operations are available

  - Store secure data
  - Retrieve secure data
  - Delete secure data

## Introduction

#### Why:
In my opinion, there are numerous stable libraries/plugins available for Android however a reliable plugin for MacOS & iOS does not seem to exist. 

This plugin currently only supports MacOS & iOS and maybe extended to other platforms if such a need arises.

It leverages [Keychain Services API](https://developer.apple.com/documentation/security/keychain_services#//apple_ref/doc/uid/TP30000897-CH203-TP1) to 
add secure data, query the secure data and delete the secure data.

## Usage
To add secure data into keychain:

    import 'package:keychain_access/keychain_access.dart';

    await keychainAccess.addSecureData(
        "uniqueSecureDataIdentifier", # Example: username, uid, etc.
        "<secure-password>", # --> Your secure data goes here.
        application: "com.company.exampleApp" # --> This is optional.
    );
    // *Note: This will throw PlatformException if the secure data with key already exists.
    // Use addOrUpdateSecureData to replace in case a record already exists with key.

---
To update secure data in keychain:


    import 'package:keychain_access/keychain_access.dart';

    await keychainAccess.updateSecureData(
        "uniqueSecureDataIdentifier", # Example: username, uid, etc.
        "<secure-password>", # --> Your secure data goes here.
        application: "com.company.exampleApp" # --> This is optional.
    );
    // *Note: This will throw PlatformException if the secure data with key does not exist.
    // Use addOrUpdateSecureData to add in case a record does not exist with key.
    // However, this does not gurantee any thread-safety.

---
To add or update secure data in keychain:

    import 'package:keychain_access/keychain_access.dart';

    await keychainAccess.addOrUpdateSecureData(
        "uniqueSecureDataIdentifier", # Example: username, uid, etc.
        "<secure-password>", # --> Your secure data goes here.
        application: "com.company.exampleApp" # --> This is optional.
    );

---
To delete secure data in keychain:

    import 'package:keychain_access/keychain_access.dart';

    await keychainAccess.deleteSecureData(
        "uniqueSecureDataIdentifier", # Example: username, uid, etc.
        "<secure-password>", # --> Your secure data goes here.
        application: "com.company.exampleApp" # --> This is optional.
    );
    // *Note: This will throw PlatformException if the secure data with key does not exist.


