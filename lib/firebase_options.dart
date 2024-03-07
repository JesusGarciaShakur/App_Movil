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
    apiKey: 'AIzaSyC_9W1GIvU0ZDYpy4_WDD61jWcKnf7B6EQ',
    appId: '1:321175735917:web:591866685e48ede83e3964',
    messagingSenderId: '321175735917',
    projectId: 'iot-fire-7e935',
    authDomain: 'iot-fire-7e935.firebaseapp.com',
    databaseURL: 'https://iot-fire-7e935-default-rtdb.firebaseio.com',
    storageBucket: 'iot-fire-7e935.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCWK6hyCgE2-0CKryTRuj8k6paW96Yxes8',
    appId: '1:321175735917:android:18f5610bd313c0403e3964',
    messagingSenderId: '321175735917',
    projectId: 'iot-fire-7e935',
    databaseURL: 'https://iot-fire-7e935-default-rtdb.firebaseio.com',
    storageBucket: 'iot-fire-7e935.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBuBtHh0Q7HEVFcU9VG0IYxtsOk8DCQYCc',
    appId: '1:321175735917:ios:9b51b62e92ac39a53e3964',
    messagingSenderId: '321175735917',
    projectId: 'iot-fire-7e935',
    databaseURL: 'https://iot-fire-7e935-default-rtdb.firebaseio.com',
    storageBucket: 'iot-fire-7e935.appspot.com',
    iosBundleId: 'com.example.smcaApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBuBtHh0Q7HEVFcU9VG0IYxtsOk8DCQYCc',
    appId: '1:321175735917:ios:0944e4bb0a881ced3e3964',
    messagingSenderId: '321175735917',
    projectId: 'iot-fire-7e935',
    databaseURL: 'https://iot-fire-7e935-default-rtdb.firebaseio.com',
    storageBucket: 'iot-fire-7e935.appspot.com',
    iosBundleId: 'com.example.smcaApplication.RunnerTests',
  );
}
