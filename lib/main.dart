
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/Message_data_model.dart';
import 'package:ezdihar_apps/models/chat_model.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/remote/notification.dart';
import 'package:ezdihar_apps/routes/app_routes.dart';
import 'package:ezdihar_apps/screens/chat/chat_page.dart';
import 'package:ezdihar_apps/screens/chat/cubit/chat_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      child:  MyApp()));

}


class MyApp extends StatefulWidget {
   MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");
  PushNotificationService? pushNotificationService;



  @override
  Widget  build(BuildContext context) {


    //  WidgetsFlutterBinding.ensureInitialized();


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
  @override
  void initState() {
    super.initState();
    pushNotificationService = PushNotificationService();
    listenToNotificationStream();
    pushNotificationService!.initialise();

  }
   void listenToNotificationStream() =>
       pushNotificationService!.behaviorSubject.listen((payload) {
         print("D;dldlldl");
         ChatModel chatModel=pushNotificationService!.behaviorchat.value;
         if (payload.contains("chat")) {
           Navigator.push(navigatorKey.currentState!.context,
               MaterialPageRoute(
                   builder: (context) => BlocProvider(
                     create: (context) => ChatCubit(),
                     child: ChatPage(
                       chatModel: chatModel,
                     ),
                   )));
         }
       });
}
