import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:songs_app/classoffunc/classes.dart';
import 'package:songs_app/classoffunc/notification.dart';
import 'package:songs_app/offlinesongs/loadingpage.dart';
import 'package:songs_app/offlinesongs/hivdb.dart';
import 'package:songs_app/offlinesongs/psearch.dart';
import 'package:songs_app/offlinesongs/song.dart';
import 'package:songs_app/offlinesongs/ohome.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  PushNotifications.init();
  PushNotifications.localNotiInit();
  await Hive.initFlutter();
  Hive.registerAdapter(SongDataAdapter());

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    foregroundMessageHandler(message);
    String payloadData = jsonEncode(message.data);
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
    }
  });
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
    }
  });

  runApp(const MyApp());
}

Future<void> foregroundMessageHandler(RemoteMessage message) async {
  if (message.data.isNotEmpty) {
    DateTime now = DateTime.now();
    String timed = "${now.day}-${now.month}-${now.year}";
    final box = await Hive.openBox('songDataBox');
    var myData = box.get('songoftheday');
    String songbok = message.data['book'].toString();
    int intValue = int.parse(message.data['number']) - 1;
    int number = intValue;
    String? notificationText = message.notification?.body;
    Map<String, dynamic> dat = {
      'book': songbok,
      'number': number,
      'title': notificationText
    };
    myData ??= {};
    myData[timed] = dat;
    sondat.clear();
    for (var i in myData.keys) {
      sondat.add({i: myData[i]});
    }
    await box.put('songoftheday', myData);
    await box.close();
  }
}

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  if (message.data.isNotEmpty) {
    if (!Hive.isBoxOpen('songDataBox')) {
      await Hive.initFlutter();
    }

    final myModelAdapter = SongDataAdapter();
    if (!Hive.isAdapterRegistered(myModelAdapter.typeId)) {
      Hive.registerAdapter(myModelAdapter);
    }
    DateTime now = DateTime.now();
    String timed = "${now.day}-${now.month}-${now.year}";
    final box = await Hive.openBox('songDataBox');
    var myData = box.get('songoftheday');
    String songbok = message.data['book'].toString();
    int intValue = int.parse(message.data['number']) - 1;
    int number = intValue;
    String? notificationText = message.notification?.body;

    Map<String, dynamic> dat = {
      'book': songbok,
      'number': number,
      'title': notificationText
    };
    myData ??= {};
    myData[timed] = dat;
    for (int i = 0; i < sondat.length; i++) {
      if (sondat[i].containsKey(timed)) {
        sondat[i]["timed"] = dat;
      }
    }
    await box.put('songoftheday', myData);
    await box.close();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void ca() async {
    await fetchdatafromBox();
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
  }

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
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
