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

    // FirebaseMessaging.onMessageOpenedApp.listen((message) {

    // });
  }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: <String, WidgetBuilder>{
      '/': (BuildContext context) => MyApp(),
      '/guest': (BuildContext context) => DynamicLinkScreen(),
    },
  ));
}

Future<void> _messageHandler(RemoteMessage message) async {
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
