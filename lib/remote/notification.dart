import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/Message_data_model.dart';
import 'package:ezdihar_apps/models/category_data_model.dart';
import 'package:ezdihar_apps/models/chat_data_model.dart';
import 'package:ezdihar_apps/models/chat_model.dart';
import 'package:ezdihar_apps/models/city_data_model.dart';
import 'package:ezdihar_apps/models/consultant_data_model.dart';
import 'package:ezdihar_apps/models/consultants_data_model.dart';
import 'package:ezdihar_apps/models/home_model.dart';
import 'package:ezdihar_apps/models/login_model.dart';
import 'package:ezdihar_apps/models/payment_model.dart';
import 'package:ezdihar_apps/models/send_general_study_model.dart';
import 'package:ezdihar_apps/models/slider_model.dart';
import 'package:ezdihar_apps/models/status_resspons.dart';
import 'package:ezdihar_apps/models/user_data_model.dart';
import 'package:ezdihar_apps/models/user_sign_up_model.dart';
import 'package:ezdihar_apps/remote/handle_exeption.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

import '../firebase_options.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';
import '../preferences/preferences.dart';
import '../routes/app_routes.dart';
import '../routes/navigation.dart';
import 'notificationlisten.dart';

class PushNotificationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  // StreamController<String> streamController = StreamController<String>.broadcast();
  final locator = GetIt.instance;
  late AndroidNotificationChannel channel;
  ChatModel? chatModel;
   MessageModel? messageDataModel;
  final BehaviorSubject<String> behaviorSubject = BehaviorSubject();
  final BehaviorSubject<ChatModel> behaviorchat = BehaviorSubject();
  RemoteMessage? initialMessage;

  late BuildContext context;

  // final BehaviorSubject<MessageModel> behaviormessage = BehaviorSubject();

  Future initialise() async {
    initialMessage =
        await FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        chatModel = ChatModel.fromJson(jsonDecode(value.data['room']));

        locator<NavigationService>().navigateToReplacement(chatModel!);
      }
    });
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: await ondidnotification);
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: notificationTapBackground,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      checkData(message);
      //showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Got a message whilstt in the foreground!');
      print('Message data: ${message.data}');

//  showNotification(message);
      checkData(message);
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {

await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
    print("Handling a background message:");

    if (message.data.isNotEmpty) {
      print("Handling a background message: ${message.data}");
      checkData(message);
    }
    // showNotification(message);
  }

  Future<void> showNotification(RemoteMessage message) async {
    //chatModel = ChatModel.fromJson(jsonDecode(message.data['room']));
    String paylod = message.data['room'] + message.data['note_type'];
    behaviorchat.add(chatModel!);
    UserModel userModel = await Preferences.instance.getUserModel();

    if (userModel.user.isLoggedIn) {
      flutterLocalNotificationsPlugin.show(
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
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    final didNotificationLaunchApp =
        notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
    print("dldldk${didNotificationLaunchApp}");
  }

  void checkData(RemoteMessage message) {
    if (message.data['note_type'].toString().contains("chat")) {
      //  if(navigatorKey.currentState!.widget.initialRoute!=AppConstant.pageChatRoute){

      chatModel = ChatModel.fromJson(jsonDecode(message.data['room']));
      var notification;
      if (message.data['data'].toString().isNotEmpty) {
        print("Flflflflssss");
        messageDataModel =
            MessageModel.fromJson(jsonDecode(message.data['data']));

        notification =
            LocalNotification("data", MessageModel.toJson(messageDataModel));
      } else {
        notification = LocalNotification("data", message.data);
      }
      behaviorchat.add(chatModel!);

      if ((AppRoutes.rout == AppConstant.pageChatRoute )&&messageDataModel!=null) {
        NotificationsBloc.instance.newNotification(notification);
      } else {

          NotificationsBloc.instance.newNotification(notification);


        showNotification(message);
      }

    } else {
      var notification = LocalNotification("data", message.data);
      NotificationsBloc.instance.newNotification(notification);

      showNotification(message);
    }
  }

  Future notificationTapBackground(NotificationResponse details) async {
    print('notification payload: ${details.payload}');
    if (details.payload!.contains("chat")) {
      chatModel = ChatModel.fromJson(jsonDecode(
          details.payload!.replaceAll("chat", "").replaceAll("room", "")));

      behaviorchat.add(chatModel!);
      behaviorSubject.add("chat");
      // streamController.add("chat");

    }
  }

  Future ondidnotification(
      int id, String? title, String? body, String? payload) async {
    print("object");
    print('notification payload: ${payload}');
    if (payload!.contains("chat")) {
      chatModel = ChatModel.fromJson(
          jsonDecode(payload!.replaceAll("chat", "").replaceAll("room", "")));

      behaviorchat.add(chatModel!);
      behaviorSubject.add("chat");
      // streamController.add("chat");

    }
    //   streamControllerstreamController.add("chat");
    // behaviorchat.add(chatModel!);
    // behaviorSubject.add(payload!);
  }
}
