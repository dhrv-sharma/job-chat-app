// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCOt2nRenK1U8_SUlcHoxvnRTkSuEIPEIY',
    appId: '1:954862977297:web:af0d345c2bb46fbef1ccb0',
    messagingSenderId: '954862977297',
    projectId: 'jobsearch-4868f',
    authDomain: 'jobsearch-4868f.firebaseapp.com',
    storageBucket: 'jobsearch-4868f.appspot.com',
    measurementId: 'G-8WT4C6TMCP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDTgmv8EtTMDAunclXoctG0se5pjzx6WsI',
    appId: '1:954862977297:android:d24f13c66cc8995bf1ccb0',
    messagingSenderId: '954862977297',
    projectId: 'jobsearch-4868f',
    storageBucket: 'jobsearch-4868f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDZdfso4tHc23YNkVERtkota_dzbgY7cLs',
    appId: '1:954862977297:ios:144c00ea0b38f394f1ccb0',
    messagingSenderId: '954862977297',
    projectId: 'jobsearch-4868f',
    storageBucket: 'jobsearch-4868f.appspot.com',
    iosBundleId: 'com.example.jobchat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDZdfso4tHc23YNkVERtkota_dzbgY7cLs',
    appId: '1:954862977297:ios:144c00ea0b38f394f1ccb0',
    messagingSenderId: '954862977297',
    projectId: 'jobsearch-4868f',
    storageBucket: 'jobsearch-4868f.appspot.com',
    iosBundleId: 'com.example.jobchat',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCOt2nRenK1U8_SUlcHoxvnRTkSuEIPEIY',
    appId: '1:954862977297:web:eb6742d1f10db973f1ccb0',
    messagingSenderId: '954862977297',
    projectId: 'jobsearch-4868f',
    authDomain: 'jobsearch-4868f.firebaseapp.com',
    storageBucket: 'jobsearch-4868f.appspot.com',
    measurementId: 'G-BEPVE6MF5J',
  );
}
