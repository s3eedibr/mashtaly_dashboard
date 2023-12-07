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
    apiKey: 'AIzaSyCAaGMi55J_u7ccZkmgHOorqNmEC-c88w0',
    appId: '1:68188123665:web:f7c2242d6421764e49b7b0',
    messagingSenderId: '68188123665',
    projectId: 'mashtalydashboard2',
    authDomain: 'mashtalydashboard2.firebaseapp.com',
    storageBucket: 'mashtalydashboard2.appspot.com',
    measurementId: 'G-R1FWXYN1TN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCjVLeqiatYV_0gD5COkFsENJnWNBOdjT8',
    appId: '1:68188123665:android:c0691240f60f15e549b7b0',
    messagingSenderId: '68188123665',
    projectId: 'mashtalydashboard2',
    storageBucket: 'mashtalydashboard2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAP0MW1W9JsWzm3nfW68BEAl_CmbSVg3c0',
    appId: '1:68188123665:ios:7dd9d4b2aa28e24f49b7b0',
    messagingSenderId: '68188123665',
    projectId: 'mashtalydashboard2',
    storageBucket: 'mashtalydashboard2.appspot.com',
    iosBundleId: 'com.example.mashtalyDashboard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAP0MW1W9JsWzm3nfW68BEAl_CmbSVg3c0',
    appId: '1:68188123665:ios:5363fc37d3360c6349b7b0',
    messagingSenderId: '68188123665',
    projectId: 'mashtalydashboard2',
    storageBucket: 'mashtalydashboard2.appspot.com',
    iosBundleId: 'com.example.mashtalyDashboard.RunnerTests',
  );
}
