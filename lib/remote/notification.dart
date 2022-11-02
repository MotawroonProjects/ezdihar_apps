import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/Message_data_model.dart';
import 'package:ezdihar_apps/models/category_data_model.dart';
import 'package:ezdihar_apps/models/chat_data_model.dart';
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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  late AndroidNotificationChannel channel;

  Future initialise() async {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings()),
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

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification!.body}');
      }
      flutterLocalNotificationsPlugin.show(
          message.notification.hashCode,
          message.notification!.title,
          message.notification!.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
               channelDescription: channel.description,
                importance: Importance.max,
                icon:'@mipmap/ic_launcher'
              )));

    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('Got a message whilstt in the foreground!');
      print('Message data: ${event.data}');

      if (event.notification != null) {
        print('Message also contained a notification: ${event.notification}');
      }
      flutterLocalNotificationsPlugin.show(
          event.notification.hashCode,
          event.notification!.title,
          event.notification!.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  importance: Importance.max,
                  icon:'@mipmap/ic_launcher'
              )));


    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.data}");
    flutterLocalNotificationsPlugin.show(
        message.notification.hashCode,
        message.notification!.title,
        message.notification!.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                importance: Importance.max,
                icon:'@mipmap/ic_launcher'
            )));
  }
}
