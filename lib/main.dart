import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:snap_eats/firebase_options.dart';

import 'app/helper/my_logger.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseAppCheck.instance.activate(

    // Set androidProvider to `AndroidProvider.debug`
    androidProvider: AndroidProvider.debug,
  );

  const isUsingFirebaseEmulator = true;
  if (isUsingFirebaseEmulator) {
    await _connectToFirebaseEmulator(
      isLocalCloudFunction: true,
      isLocalFirebaseAuth: false,
      isLocalFirebaseStorage: false,
      isLocalFirestore: true,
    );
    MyLogger.printMessage('FIREBASE EMULATOR IS IN USE');
  }

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.DASHBOARD,
      getPages: AppPages.routes,
    ),
  ));
}

// https://firebase.google.com/docs/emulator-suite/connect_and_prototype
Future<void> _connectToFirebaseEmulator({
  required bool isLocalCloudFunction,
  required bool isLocalFirebaseAuth,
  required bool isLocalFirebaseStorage,
  required bool isLocalFirestore,
}) async {
  final localHost = Platform.isAndroid ? '10.0.2.2' : 'localhost';

  // You can get these port numbers from firebase.json


  if (isLocalCloudFunction) {
    FirebaseFunctions.instanceFor(region: 'asia-southeast2')
        .useFunctionsEmulator(localHost, 5001);
  }
  if (isLocalFirestore) {
    FirebaseFirestore.instance.settings = Settings(
      host: '$localHost:8080',
      persistenceEnabled: false,
      sslEnabled: false,
    );
  }
  if (isLocalFirebaseAuth) {
    await FirebaseAuth.instance.useAuthEmulator(localHost, 9099);
  }

  if (isLocalFirebaseStorage) {
    await FirebaseStorage.instance.useStorageEmulator(localHost, 9199);
  }


}
