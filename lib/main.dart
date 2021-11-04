import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:telemedicine_mobile/Screens/components/loading.dart';
import 'package:telemedicine_mobile/Screens/dynamic_link_screen.dart';
import 'package:telemedicine_mobile/controller/invite_videocall_controller.dart';
import 'controller/facebook_login_controller.dart';
import 'controller/google_login_controller.dart';
import 'package:telemedicine_mobile/Screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    new FlutterLocalNotificationsPlugin();
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await [Permission.microphone, Permission.camera, Permission.location]
      .request();
  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings();
  var initializationSettings = new InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        playSound: true,
        enableVibration: true);

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onBackgroundMessage(_messageHandler);
  }

  runApp(MaterialApp(
    routes: <String, WidgetBuilder>{
      '/': (BuildContext context) => MyApp(),
      '/guest': (BuildContext context) => DynamicLinkScreen(),
    },
  ));
}

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
  showNotification(
      message.notification!.title ?? "", message.notification!.body ?? "");
}

void showNotification(String title, String body) async {
  await _demoNotification(title, body);
}

Future<void> _demoNotification(String title, String body) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_ID', 'channel name',
      importance: Importance.max,
      playSound: true,
      showProgress: true,
      priority: Priority.high,
      ticker: 'test ticker');
  var iOSChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);

  await flutterLocalNotificationsPlugin
      .show(0, title, body, platformChannelSpecifics, payload: 'test');
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final inviteVideoCallController = Get.put(InviteVideoCallController());

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }

  Future<void> initDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
      // ignore: unawaited_futures
      Navigator.pushNamed(context, deepLink.path);
    }
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
          final Uri? deepLink = dynamicLink?.link;

          String? healthCheckID =
              deepLink?.queryParameters['healthCheckID'].toString();
          inviteVideoCallController.healthCheckIDInvite.value =
              int.parse(healthCheckID.toString());
          if (deepLink != null) {
            // ignore: unawaited_futures
            Navigator.pushNamed(
                context, "/" + deepLink.path.toString().split("/")[1]);
          }
        },
        onError: (OnLinkErrorException e) async {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GoogleSignInController(),
          child: LoadingIcon(),
        ),
        ChangeNotifierProvider(
          create: (context) => FacebookSignInController(),
          child: LoadingIcon(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Tele Medicine',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
        localizationsDelegates: [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('en', 'US')],
      ),
    );
  }
}

// // ignore_for_file: require_trailing_commas
// // Copyright 2019 The Chromium Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

// import 'dart:async';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:telemedicine_mobile/Screens/dynamic_link_screen.dart';
// import 'package:url_launcher/url_launcher.dart';

// void main() {
//   runApp(MaterialApp(
//     title: 'Dynamic Links Example',
//     routes: <String, WidgetBuilder>{
//       '/': (BuildContext context) => MyApp(),
//       '/eNh4': (BuildContext context) => DynamicLinkScreen(),
//     },
//   ));
// }

// class MyApp extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MyApp> {
//   String? _linkMessage;
//   bool _isCreatingLink = false;

//   @override
//   void initState() {
//     super.initState();
//     initDynamicLinks();
//   }

//   Future<void> initDynamicLinks() async {
//     FirebaseDynamicLinks.instance.onLink(
//         onSuccess: (PendingDynamicLinkData? dynamicLink) async {
//       final Uri? deepLink = dynamicLink?.link;

//       if (deepLink != null) {
//         // ignore: unawaited_futures
//         Navigator.pushNamed(context, deepLink.path);
//       }
//     }, onError: (OnLinkErrorException e) async {
//       print('onLinkError');
//       print(e.message);
//     });

//     final PendingDynamicLinkData? data =
//         await FirebaseDynamicLinks.instance.getInitialLink();
//     final Uri? deepLink = data?.link;

//     if (deepLink != null) {
//       // ignore: unawaited_futures
//       Navigator.pushNamed(context, deepLink.path);
//     }
//   }

//   Future<void> _createDynamicLink() async {
//     setState(() {
//       _isCreatingLink = true;
//     });

//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: 'https://metacine.page.link/',
//       link: Uri.parse('https://metacine.page.link/eNh4'),
//       androidParameters: AndroidParameters(
//         packageName: 'com.example.telemedicine_mobile',
//       ),
//     );

//     Uri url;
//     final ShortDynamicLink shortLink = await parameters.buildShortLink();
//     url = shortLink.shortUrl;

//     setState(() {
//       _linkMessage = url.toString();
//       _isCreatingLink = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Dynamic Links Example'),
//         ),
//         body: Builder(builder: (BuildContext context) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 ButtonBar(
//                   alignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     ElevatedButton(
//                       onPressed:
//                           !_isCreatingLink ? () => _createDynamicLink() : null,
//                       child: const Text('Get Short Link'),
//                     ),
//                   ],
//                 ),
//                 InkWell(
//                   onTap: () async {
//                     if (_linkMessage != null) {
//                       await launch(_linkMessage!);
//                     }
//                   },
//                   onLongPress: () {
//                     Clipboard.setData(ClipboardData(text: _linkMessage));
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Copied Link!')),
//                     );
//                   },
//                   child: Text(
//                     _linkMessage ?? '',
//                     style: const TextStyle(color: Colors.blue),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }
