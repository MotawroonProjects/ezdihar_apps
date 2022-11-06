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
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

import '../models/contact_us_model.dart';
import '../models/feasibility_type.dart';
import '../models/provider_home_page_model.dart';
import '../models/provider_model.dart';
import '../models/provider_order.dart';
import '../models/recharge_wallet_model.dart';
import '../models/send_service_request_model.dart';
import '../models/setting_model.dart';
import '../models/single_Message_data_model.dart';
import '../models/user.dart';
import '../models/user_model.dart';
import '../screens/chat/chat_page.dart';

class PushNotificationService{
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  late AndroidNotificationChannel channel;
  late ChatModel chatModel;
  final BehaviorSubject<String> behaviorSubject = BehaviorSubject();
  final BehaviorSubject<ChatModel> behaviorchat = BehaviorSubject();

  Future initialise() async {

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
            onDidReceiveLocalNotification: ondidnotification);
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: notificationTapBackground);

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
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.data}");
    checkData(message);

    // showNotification(message);
  }

  void showNotification(RemoteMessage message) {
    flutterLocalNotificationsPlugin.show(
        message.data.hashCode,
        message.data['title'],
        message.data['body'],
        payload: 'chat',
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                importance: Importance.max,
                icon: '@mipmap/ic_launcher')));
  }

  void checkData(RemoteMessage message) {
    if (message.data['note_type'].toString().contains("chat")) {
      chatModel = ChatModel.fromJson(jsonDecode(message.data['room']));
      behaviorchat.add(chatModel);
      // if (ModalRoute.of(context)!
      //     .settings
      //     .name!
      //     .contains(AppConstant.pageChatRoute)) {
      //   //Navigator.of(context).pop();
      //   // context..addmessage(message.data['data']);
      // } else {
        showNotification(message);
      //}
    } else {
      showNotification(message);
    }
  }

  Future notificationTapBackground(NotificationResponse details) async {
    print('notification payload: ${details.payload}');
    if (details.payload!.contains("chat")) {
      behaviorSubject.add(details.payload!);

    }
  }

  void ondidnotification(
      int id, String? title, String? body, String? payload) async {
    print("object");
    behaviorSubject.add(payload!);
  }


}
