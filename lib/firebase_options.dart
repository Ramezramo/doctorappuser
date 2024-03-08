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
    apiKey: 'AIzaSyCDT-aiB_gnvv9SXZrZ71lRzvLuO65bN8U',
    appId: '1:1070713229887:web:7ff6627aa9fc971df01e8a',
    messagingSenderId: '1070713229887',
    projectId: 'doctorapp-d17bc',
    authDomain: 'doctorapp-d17bc.firebaseapp.com',
    storageBucket: 'doctorapp-d17bc.appspot.com',
    measurementId: 'G-2QS03NFFES',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBrAAobWFqwVlatng1lCBmz6Gh5TuhTto4',
    appId: '1:1070713229887:android:7cd88aa1f026e5def01e8a',
    messagingSenderId: '1070713229887',
    projectId: 'doctorapp-d17bc',
    storageBucket: 'doctorapp-d17bc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAObfcppMhX08-fCLPwGwsXfNnTNIrJM9E',
    appId: '1:1070713229887:ios:4a6898dcf4fa2964f01e8a',
    messagingSenderId: '1070713229887',
    projectId: 'doctorapp-d17bc',
    storageBucket: 'doctorapp-d17bc.appspot.com',
    iosBundleId: 'com.example.doctorapplast',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAObfcppMhX08-fCLPwGwsXfNnTNIrJM9E',
    appId: '1:1070713229887:ios:bb969d52a050b883f01e8a',
    messagingSenderId: '1070713229887',
    projectId: 'doctorapp-d17bc',
    storageBucket: 'doctorapp-d17bc.appspot.com',
    iosBundleId: 'com.example.doctorapplast.RunnerTests',
  );
}