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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBcq4lfWzi_VbS1jt1z3KY_vCYUkHVE-Fc',
    appId: '1:552709284925:web:c18cb7f678caa5c70bb654',
    messagingSenderId: '552709284925',
    projectId: 'clone-c5720',
    authDomain: 'clone-c5720.firebaseapp.com',
    storageBucket: 'clone-c5720.appspot.com',
    measurementId: 'G-CQHTSFD1ZD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAtsL5GHukO_jPw7qwsVJF6XGc7wpuaajs',
    appId: '1:552709284925:android:63b4f81faf546d940bb654',
    messagingSenderId: '552709284925',
    projectId: 'clone-c5720',
    storageBucket: 'clone-c5720.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGprUucydtrpGkAyJy3sI3jqa03Jem0wA',
    appId: '1:552709284925:ios:05b25906be3b16ae0bb654',
    messagingSenderId: '552709284925',
    projectId: 'clone-c5720',
    storageBucket: 'clone-c5720.appspot.com',
    iosBundleId: 'com.example.gestuspeak',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCGprUucydtrpGkAyJy3sI3jqa03Jem0wA',
    appId: '1:552709284925:ios:6b0d5eddb459ed0c0bb654',
    messagingSenderId: '552709284925',
    projectId: 'clone-c5720',
    storageBucket: 'clone-c5720.appspot.com',
    iosBundleId: 'com.example.gestuspeak.RunnerTests',
  );
}
