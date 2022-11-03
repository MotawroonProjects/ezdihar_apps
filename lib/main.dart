import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/models/Message_data_model.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/remote/notification.dart';
import 'package:ezdihar_apps/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('ar', ''), Locale('en', '')],
      path: 'assets/lang',
      saveLocale: false,
      startLocale: const Locale('ar', ''),
      fallbackLocale: const Locale('ar', ''),
      child: const MyApp()));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     PushNotificationService().initialise(context);

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
        onGenerateRoute: AppRoutes.getRoutes);
  }
}
