import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/models/consultant_type_model.dart';
import 'package:ezdihar_apps/models/login_model.dart';
import 'package:ezdihar_apps/screens/accounting_consultants_screen/accounting_consultants_screen.dart';
import 'package:ezdihar_apps/screens/add_screen/add_screen.dart';
import 'package:ezdihar_apps/screens/auth_screens/consultant_sign_up/consultant_sign_up.dart';
import 'package:ezdihar_apps/screens/auth_screens/consultant_sign_up/cubit/consultant_cubit.dart';
import 'package:ezdihar_apps/screens/auth_screens/invistor_sign_up/cubit/investor_cubit.dart';
import 'package:ezdihar_apps/screens/auth_screens/invistor_sign_up/investor_sign_up_screen.dart';
import 'package:ezdihar_apps/screens/auth_screens/login_screen/cubit/login_cubit.dart';
import 'package:ezdihar_apps/screens/auth_screens/login_screen/login_screen.dart';
import 'package:ezdihar_apps/screens/auth_screens/user_role_screen/user_role_screen.dart';
import 'package:ezdihar_apps/screens/auth_screens/user_sign_up/cubit/user_sign_up_cubit.dart';
import 'package:ezdihar_apps/screens/auth_screens/user_sign_up/user_sign_up_screen.dart';
import 'package:ezdihar_apps/screens/cities_screen/cities_page.dart';
import 'package:ezdihar_apps/screens/cities_screen/cubit/cities_cubit.dart';
import 'package:ezdihar_apps/screens/consultant_details_screen/consultant_details.dart';
import 'package:ezdihar_apps/screens/contact_us_screen/contact_us_screen.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/consulting_screen/cubit/consulting_cubit.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/home_screen/HomePage.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/main_screen/cubit/main_page_cubit.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/more_screen/cubit/more_cubit.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/service_screen/cubit/services_cubit.dart';
import 'package:ezdihar_apps/screens/investment_details_screen/investment_details_screen.dart';
import 'package:ezdihar_apps/screens/offer_screen/offer_screen.dart';
import 'package:ezdihar_apps/screens/request_consultation_screen/request_consultation_screen.dart';
import 'package:ezdihar_apps/screens/send_general_study_screen/send_general_study_screen.dart';
import 'package:ezdihar_apps/screens/settings_screen/setting_screen.dart';
import 'package:ezdihar_apps/screens/splashPage/splash_page.dart';
import 'package:ezdihar_apps/screens/wallet_screen/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/home_page/navigation_screens/home_screen/cubit/home_page_cubit.dart';

class AppRoutes {
  static late HomePageCubit homePageCubit;

  static Route<dynamic>? getRoutes(RouteSettings settings) {
    print('ROUTENAME${settings.name}');
    switch (settings.name) {
      case AppConstant.pageSplashRoute:
        return MaterialPageRoute(builder: (context) => const SplashPage());


      case AppConstant.pageHomeRoute:
      /*BlocProvider<HomePageCubit>(
          create: (context) {
            homePageCubit = HomePageCubit();
            return homePageCubit;
          },
          child: const HomePage(),
        );*/
        return MaterialPageRoute(builder: (context) {
          return MultiBlocProvider(providers: [
            BlocProvider<HomePageCubit>(create: (context) {
              homePageCubit = HomePageCubit();
              return homePageCubit;
            }),
            BlocProvider<MainPageCubit>(create: (context) => MainPageCubit()),
            BlocProvider<ConsultingCubit>(create: (context) => ConsultingCubit()),
            BlocProvider<ServicesCubit>(create: (context) => ServicesCubit()),
            BlocProvider<MoreCubit>(create: (context) => MoreCubit())


          ], child: const HomePage());
        });
      case AppConstant.pageSettingRoute:
        return MaterialPageRoute(builder: (context) => const SettingPage());

      case AppConstant.pageAddRoute:
        return MaterialPageRoute(builder: (context) => const AddPage());

      case AppConstant.pageInvestmentDetailsRoute:
        return MaterialPageRoute(
            builder: (context) => const InvestmentDetailsPage());
      case AppConstant.pageAccountingConsultantsRoute:
        ConsultantTypeModel consultantTypeModel = settings.arguments as ConsultantTypeModel;
        return MaterialPageRoute(
            builder: (context) =>  AccountingConsultantsPage(consultantTypeModel: consultantTypeModel,));

      case AppConstant.pageOfferRoute:
        return MaterialPageRoute(builder: (context) => const OfferPage());

      case AppConstant.pageWalletRoute:
        return MaterialPageRoute(builder: (context) => const WalletPage());

      case AppConstant.pageContactUsRoute:
        return MaterialPageRoute(builder: (context) => const ContactUsPage());
      case AppConstant.pageConsultantDetailsRoute:
        int consultant_id = settings.arguments as int;

        return MaterialPageRoute(
            builder: (context) => ConsultantDetailsPage(consultant_id: consultant_id,));
      case AppConstant.pageRequestConsultationRoute:
        return MaterialPageRoute(
            builder: (context) => const RequestConsultationPage());
      case AppConstant.pageSendGeneralStudyRoute:
        String title = settings.arguments.toString();
        return MaterialPageRoute(
            builder: (context) => SendGeneralStudyScreen(title: title,));
      case AppConstant.pageLoginRoute:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider<LoginCubit>(create: (context) {
            LoginCubit cubit = LoginCubit();
            return cubit;
          }, child: LoginPage(),);
        });

      case AppConstant.pageUserRoleRoute:
        return MaterialPageRoute(builder: (context) => const UserRolePage());

      case AppConstant.pageUserSignUpRoleRoute:
        LoginModel loginModel=  settings.arguments as LoginModel;
        return MaterialPageRoute(builder: (context) {
          return BlocProvider<UserSignUpCubit>(
            create: (context) => UserSignUpCubit(),
            child: UserSignUpPage(loginModel: loginModel,),
          );
        });

      case AppConstant.pageInvestorSignUpRoleRoute:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider<InvestorCubit>(
            create: (context) => InvestorCubit(),
            child: InvestorSignUpPage(),
          );
        });
      case AppConstant.pageConsultantSignUpRoleRoute:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider<ConsultantSignUpCubit>(
            create: (context) => ConsultantSignUpCubit(),
            child: ConsultantSignUpPage(),
          );
        });

      case AppConstant.pageCitiesRoute:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider<CitiesCubit>(
            create: (context) => CitiesCubit(),
            child: CitiesPage(),
          );
        });
    }
  }
}
