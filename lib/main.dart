import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rovertaxi/pushNotification/pushNotification.dart';

import 'Utilities/routes/myRoute.dart';
import 'Utilities/routes/routes_name.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

/// Function to listen to background changes
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print('Some Notification Received');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// On Background Notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print('Background Notification Tapped');
      // navigatorKey.currentState.pushNamed(routeName)
    }
  });
  PushNotifications.init();
  PushNotifications.localNotiInit();

  /// Listen to background Notification
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  /// to handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
    }
  });

  /// for handling in terminated state
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Launched from terminated state");
    Future.delayed(Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rover Taxi',
      theme: ThemeData(
          // fontFamily: 'Poppins',
          primarySwatch: Colors.blue),
      initialRoute: RoutesName.splshView,
      onGenerateRoute: MyRoute.generateRoute,
    );
  }
}
