import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:songs_app/classoffunc/classes.dart';
import 'package:songs_app/classoffunc/notification.dart';
import 'package:songs_app/loadingpage.dart';
import 'package:songs_app/offlinesongs/psearch.dart';
import 'package:songs_app/offlinesongs/song.dart';
import 'package:songs_app/offlinesongs/ohome.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  PushNotifications.init();
  PushNotifications.localNotiInit();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void ca() async {
    RemoteMessage? initialmessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialmessage != null) {
      await navigatorKey.currentState!.pushNamed("/process");
      if (initialmessage.data['book'] == 'HEBRON SONGS') {
        book1 = 'HEBRON_SONGS';
      } else if (initialmessage.data['book'] == 'ZION SONGS') {
        book1 = 'ZION_SONGS';
      }
      await Decorate().fetchDataFromJsonFile();
      await navigatorKey.currentState!
          .pushNamed("/song", arguments: initialmessage);
      setState(() {});
    }
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (message.notification != null) {
        await navigatorKey.currentState!.pushNamed("/process");
        if (message.data['book'] == 'HEBRON SONGS') {
          book1 = 'HEBRON_SONGS';
        } else if (message.data['book'] == 'ZION SONGS') {
          book1 = 'ZION_SONGS';
        }
        await Decorate().fetchDataFromJsonFile();
        await navigatorKey.currentState!.pushNamed("/song", arguments: message);
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    ca();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HebronPage(),
        '/song': (context) => const HebronSong(),
        '/genre': (context) => const MyHomePage1(),
        '/process': (context) => const ProgressIndicatorPage()
      },
    );
  }
}
