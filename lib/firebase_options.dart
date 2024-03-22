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
    apiKey: 'AIzaSyCGeO9X01brIfhPZphJ2NupsBHHqZL14ps',
    appId: '1:58822421527:web:f071d4a1bf3020b6554052',
    messagingSenderId: '58822421527',
    projectId: 'newiot-632c1',
    authDomain: 'newiot-632c1.firebaseapp.com',
    databaseURL: 'https://newiot-632c1-default-rtdb.firebaseio.com',
    storageBucket: 'newiot-632c1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC2iv032M6wun7AQ2RtpqqMNNWFGMFJAkk',
    appId: '1:58822421527:android:a14c387bff2fcfef554052',
    messagingSenderId: '58822421527',
    projectId: 'newiot-632c1',
    databaseURL: 'https://newiot-632c1-default-rtdb.firebaseio.com',
    storageBucket: 'newiot-632c1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxqbWy3uJzbScPxXKRe1NJL_1dd1GRwE8',
    appId: '1:58822421527:ios:0d130ced33900eb6554052',
    messagingSenderId: '58822421527',
    projectId: 'newiot-632c1',
    databaseURL: 'https://newiot-632c1-default-rtdb.firebaseio.com',
    storageBucket: 'newiot-632c1.appspot.com',
    iosBundleId: 'com.example.smcaApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCxqbWy3uJzbScPxXKRe1NJL_1dd1GRwE8',
    appId: '1:58822421527:ios:b5144508eb186a55554052',
    messagingSenderId: '58822421527',
    projectId: 'newiot-632c1',
    databaseURL: 'https://newiot-632c1-default-rtdb.firebaseio.com',
    storageBucket: 'newiot-632c1.appspot.com',
    iosBundleId: 'com.example.smcaApplication.RunnerTests',
  );
}
