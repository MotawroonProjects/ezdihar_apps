import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/Message_data_model.dart';
import 'package:ezdihar_apps/models/chat_model.dart';
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
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
RemoteMessage? initialMessage ;
Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

 initialMessage= await FirebaseMessaging.instance.getInitialMessage().then((value) {
   if(value!=null){
     chatModel = ChatModel.fromJson(jsonDecode(value.data['room']));


     locator<NavigationService>().navigateToReplacement(chatModel);}
 }
   );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await EasyLocalization.ensureInitialized();

  //await  pushNotificationService!.callbackground();
  //
  //NavigationService().setupLocator();

  await pushNotificationService!.initialise();
  await setupLocator();


  runApp(EasyLocalization(
      supportedLocales: const [Locale('ar', ''), Locale('en', '')],
      path: 'assets/lang',
      saveLocale: false,
      startLocale: const Locale('ar', ''),
      fallbackLocale: const Locale('ar', ''),
      child: MyApp()));
}

Future setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());
}

PushNotificationService? pushNotificationService =
    new PushNotificationService();
final locator = GetIt.instance;
late ChatModel chatModel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
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
  void initState()  {
    super.initState();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen


    listenToNotificationStream();

//     pushNotificationService!.streamController.stream.listen((event) async {
// print("fkkfkfk");
//       ChatModel chatModel=pushNotificationService!.behaviorchat.value;
// locator<NavigationService>().navigateToReplacement(chatModel);
//
//      // await   Navigator.of(context).push(
//      //        MaterialPageRoute(
//      //            builder: (context) => BlocProvider(
//      //              create: (context) => ChatCubit(),
//      //              child: ChatPage(
//      //                chatModel: chatModel,
//      //              ),
//      //            )));
//
//     });
  }

  void listenToNotificationStream() =>
      pushNotificationService!.behaviorSubject.listen((payload) {
        print("D;dldlldl");
        print(payload);
        //  ChatModel chatModel = pushNotificationService!.behaviorchat.value;
        if (payload.contains("chat")) {
          if(pushNotificationService!.behaviorchat.hasValue){
            chatModel = pushNotificationService!.behaviorchat.value;
            locator<NavigationService>().navigateToReplacement(chatModel);

          }
          // Navigator.of(context).push(
          //     MaterialPageRoute(
          //         builder: (context) => BlocProvider(
          //           create: (context) => ChatCubit(),
          //           child: ChatPage(
          //             chatModel: chatModel,
          //           ),
          //         )));
        }
      });
}

// Future<void> _firebaseMessagingBackgroundHandler (
//     RemoteMessage message) async {
//   await Firebase.initializeApp();
//   if(message.data.isNotEmpty) {
//     print("Handling a background message: ${message.data}");
//     checkData(message);
//   }
//   // showNotification(message);
// }

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message:");
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
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: notificationTapBackground);
  if (message.data.isNotEmpty) {
    checkData(message);

    print("Handling a background message: ${message.data}");
  }
}

void showNotification(RemoteMessage message) async{
  chatModel = ChatModel.fromJson(jsonDecode(message.data['room']));

  behaviorchat.add(chatModel);
  String paylod=message.data['room']+message.data['note_type'];

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
  );
await  flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      payload: paylod,


      NotificationDetails(
          android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              importance: Importance.max,
              icon: '@mipmap/ic_launcher')));
  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

}

void checkData(RemoteMessage message) {
  if (message.data['note_type'].toString().contains("chat")) {
    //  if(navigatorKey.currentState!.widget.initialRoute!=AppConstant.pageChatRoute){

    chatModel = ChatModel.fromJson(jsonDecode(message.data['room']));

   behaviorchat.add(chatModel);
    // behaviorSubject.add("chat");
    //  behaviormessage.add(messageDataModel);
    // print("sslsllslsl${navigatorKey.currentState}");
    showNotification(message);
    // NotificationsBloc.instance.newNotification(notification);
    //  print("dldkkdk${messageDataModel.type}");
    // if (ModalRoute.of(context)!
    //     .settings
    //     .name!
    //     .contains(AppConstant.pageChatRoute)) {
    //   //Navigator.of(context).pop();
    //   // context..addmessage(message.data['data']);
    // } else {

    //}
  } else {
    showNotification(message);
  }


}
// showNotification(message);
Future ondidnotification(
    int id, String? title, String? body, String? payload) async {
  print("object");
  if (payload!.contains("chat")) {
    // chatModel = ChatModel.fromJson(jsonDecode(details['room']));
    chatModel = ChatModel.fromJson(jsonDecode(payload!.replaceAll("chat", "").replaceAll("room", "")));


    locator<NavigationService>().navigateToReplacement(chatModel);
    // streamController.add("chat");

  }

  //   streamController.add("chat");

}
Future notificationTapBackground(NotificationResponse details) async {
  print('notification payload: ${details.payload}');

  if (details.payload!.contains("chat")) {
   // chatModel = ChatModel.fromJson(jsonDecode(details['room']));
    chatModel = ChatModel.fromJson(jsonDecode(details.payload!.replaceAll("chat", "").replaceAll("room", "")));


    locator<NavigationService>().navigateToReplacement(chatModel);
    // streamController.add("chat");

  }

}
