// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB03bwqzHayQXnFUf0NBUa3Ypv71A9MCOk',
    appId: '1:103842313047:android:04b3d85837752d7bb7c412',
    messagingSenderId: '103842313047',
    projectId: 'chat-up-466d0',
    storageBucket: 'chat-up-466d0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC3lV_YcflvGqX6XC2gO2KaSXscq0xN8Ew',
    appId: '1:103842313047:ios:363d5c627aa6be4bb7c412',
    messagingSenderId: '103842313047',
    projectId: 'chat-up-466d0',
    storageBucket: 'chat-up-466d0.appspot.com',
    androidClientId: '103842313047-8gi0c5qhiagkkkuov6t5qde0t910udb2.apps.googleusercontent.com',
    iosClientId: '103842313047-d39n3k074kp4u9a8ijnvls5cs5n8ee29.apps.googleusercontent.com',
    iosBundleId: 'com.example.tryApp',
  );
}
