import 'dart:developer';

import 'package:firebase/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'assets/app_theme.dart';

void main() async {
  final FirebaseAnalytics analytics = FirebaseAnalytics();
  final FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  runZoned<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    Crashlytics.instance.enableInDevMode = true;
    FlutterError.onError = Crashlytics.instance.recordFlutterError;

    if (analytics != null) {
      await analytics.logEvent(
        name: 'app_started_1',
        parameters: <String, dynamic>{
          'string': 'string',
          'int': 42,
          'long': 12345678910,
          'double': 42.0,
          'bool': true,
        },
      );

      log('log app open');
    }

    runApp(new MaterialApp(
        title: 'MR HALF',
        theme: AppTheme.lightTheme,
        navigatorObservers: <NavigatorObserver>[observer],
        home: Main(observer: observer, analytics: analytics)));
  }, onError: Crashlytics.instance.recordError);
}
