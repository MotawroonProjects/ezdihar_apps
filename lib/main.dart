import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Firebase.initializeApp();

  runApp(EasyLocalization(
      supportedLocales: const [Locale('ar',''), Locale('en','')],
      path: 'assets/lang',
      saveLocale: false,
      startLocale: const Locale('ar',''),
      fallbackLocale: const Locale('ar',''),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

   Preferences.instance.getAppSetting().then((value) => {
   EasyLocalization.of(context)!.setLocale(Locale(value.lang))
   });

    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        initialRoute: "/",
        debugShowCheckedModeBanner: false,
        theme:  ThemeData(
          fontFamily: 'normal',
          checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.all(AppColors.colorPrimary),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0))
          )
        ),
        onGenerateRoute: AppRoutes.getRoutes);
  }




}
