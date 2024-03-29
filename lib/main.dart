import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/Message_data_model.dart';
import 'package:ezdihar_apps/models/chat_model.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/remote/notification.dart';
import 'package:ezdihar_apps/routes/app_routes.dart';
import 'package:ezdihar_apps/routes/navigation.dart';
import 'package:ezdihar_apps/screens/chat/chat_page.dart';
import 'package:ezdihar_apps/screens/chat/cubit/chat_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

import 'firebase_options.dart';

RemoteMessage? initialMessage;

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  UserModel userModel = await Preferences.instance.getUserModel();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (userModel.user.isLoggedIn) {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await pushNotificationService!.initialise();
  }
  await EasyLocalization.ensureInitialized();
  await setupLocator();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar', ''), Locale('en', '')],
      path: 'assets/lang',
      saveLocale: false,
      startLocale: const Locale('ar', ''),
      fallbackLocale: const Locale('ar', ''),
      child: MyApp(),
    ),
  );
}

Future setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());
}

PushNotificationService? pushNotificationService =
    new PushNotificationService();
final locator = GetIt.instance;
late ChatModel chatModel;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

late AndroidNotificationChannel channel;
final BehaviorSubject<ChatModel> behaviorchat = BehaviorSubject();

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //  WidgetsFlutterBinding.ensureInitialized();

    pushNotificationService!.context = context;
    Preferences.instance.getAppSetting().then((value) =>
        {EasyLocalization.of(context)!.setLocale(Locale(value.lang))});

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: "/",
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            DropdownAlert(
              warningBackground: AppColors.colorPrimary,
            )
          ],
        );
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'normal',
          tabBarTheme: TabBarTheme(
              labelColor: Colors.pink[800],
              labelStyle: TextStyle(color: Colors.pink[800]),
              // color for text
              indicator: UnderlineTabIndicator(
                  // color for indicator (underline)
                  borderSide: BorderSide(color: AppColors.red))),
          checkboxTheme: CheckboxThemeData(
              fillColor: MaterialStateProperty.all(AppColors.colorPrimary),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0)))),
      onGenerateRoute: AppRoutes.getRoutes,
      navigatorKey: locator<NavigationService>().navigationKey,
    );
  }

  @override
  void initState() {
    super.initState();
    _runWhileAppIsTerminated();
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Got a message whilstt in the foreground!');
      Fluttertoast.showToast(
          msg: message.data.toString() + "lkkfkfk", // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.BOTTOM, // location
          timeInSecForIosWeb: 1 // duration
          );
    });
    listenToNotificationStream();
  }

  void listenToNotificationStream() =>
      pushNotificationService!.behaviorSubject.listen((payload) {
        print("D;dldlldl");
        print(payload);
        if (payload.contains("chat")) {
          if (pushNotificationService!.behaviorchat.hasValue) {
            chatModel = pushNotificationService!.behaviorchat.value;
            locator<NavigationService>().navigateToReplacement(chatModel);
          }
        }
      });
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("Handling a background message:");

  AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          onDidReceiveLocalNotification: await ondidnotification);
  final LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(defaultActionName: 'Open notification');
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux);
  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: notificationTapBackground,
  );

  if (message.data.isNotEmpty) {
    checkData(message);

    print("Handling a background message: ${message.data}");
  }
}

void showNotification(RemoteMessage message) async {
  String paylod = "";
  if (message.data["note_type"] == "chat") {
    chatModel = ChatModel.fromJson(jsonDecode(message.data['room']));

    behaviorchat.add(chatModel);
    paylod = message.data['room'] + message.data['note_type'];
  } else {
    message.data['note_type'];
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
  );
  UserModel userModel = await Preferences.instance.getUserModel();

  if (userModel.user.isLoggedIn) {
    await flutterLocalNotificationsPlugin.show(
        message.data.hashCode,
        message.data['title'],
        message.data['body'],
        payload: paylod,
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                importance: Importance.max,
                icon: '@mipmap/ic_launcher')));
  }
}

void checkData(RemoteMessage message) {
  if (message.data['note_type'].toString().contains("chat")) {
    chatModel = ChatModel.fromJson(jsonDecode(message.data['room']));
    behaviorchat.add(chatModel);
    showNotification(message);
  } else {
    showNotification(message);
  }
}

Future ondidnotification(
    int id, String? title, String? body, String? payload) async {
  print("object");
  if (payload!.contains("chat")) {
    chatModel = ChatModel.fromJson(
        jsonDecode(payload.replaceAll("chat", "").replaceAll("room", "")));
    locator<NavigationService>().navigateToReplacement(chatModel);
  } else if (payload == "service_request") {}
}

Future notificationTapBackground(NotificationResponse details) async {
  print('notification payload: ${details.payload}');
  if (details.payload!.contains("chat")) {
    chatModel = ChatModel.fromJson(jsonDecode(
        details.payload!.replaceAll("chat", "").replaceAll("room", "")));
    locator<NavigationService>().navigateToReplacement(chatModel);
  }
}

Future onNotification(String payload) async {
  print(payload);
  if (payload.contains("chat")) {
    chatModel = ChatModel.fromJson(
        jsonDecode(payload.replaceAll("chat", "").replaceAll("room", "")));
    locator<NavigationService>().navigateToReplacement(chatModel);
  }
}

void _runWhileAppIsTerminated() async {
  await flutterLocalNotificationsPlugin
      .getNotificationAppLaunchDetails()
      .then((value) => {
            if (value != null &&
                value.notificationResponse != null &&
                value.notificationResponse!.payload!.isNotEmpty)
              {
                chatModel = ChatModel.fromJson(jsonDecode(value!
                    .notificationResponse!.payload
                    .toString()
                    .replaceAll("chat", "")
                    .replaceAll("room", ""))),
                AppRoutes.chatmodel = chatModel
              }
          });
}
