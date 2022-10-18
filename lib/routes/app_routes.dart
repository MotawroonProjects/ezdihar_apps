import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/models/consultant_type_model.dart';
import 'package:ezdihar_apps/models/login_model.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/screens/auth_screens/user_role_screen/cubit/user_role_cubit.dart';
import 'package:ezdihar_apps/screens/category_screen/category_page.dart';
import 'package:ezdihar_apps/screens/category_screen/cubit/category_cubit.dart';
import 'package:ezdihar_apps/screens/chat/chat_page.dart';
import 'package:ezdihar_apps/screens/chat/cubit/chat_cubit.dart';
import 'package:ezdihar_apps/screens/user/accounting_consultants_screen/accounting_consultants_screen.dart';
import 'package:ezdihar_apps/screens/user/accounting_consulting_by_subCategory_screen/accounting_consultants_screen.dart';
import 'package:ezdihar_apps/screens/user/accounting_provider/cubit/provider_details_cubit.dart';
import 'package:ezdihar_apps/screens/user/accounting_provider/provider_details.dart';
import 'package:ezdihar_apps/screens/user/add_screen/add_screen.dart';
import 'package:ezdihar_apps/screens/user/add_screen/cubit/add_screen_cubit.dart';
import 'package:ezdihar_apps/screens/user/add_screen/navigation_screens/feasibility_screen/cubit/feasibility_cubit.dart';
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
import 'package:ezdihar_apps/screens/user/consultant_details_screen/consultant_details.dart';
import 'package:ezdihar_apps/screens/user/consultant_details_screen/cubit/consultant_details_cubit.dart';
import 'package:ezdihar_apps/screens/user/contact_us_screen/contact_us_screen.dart';
import 'package:ezdihar_apps/screens/user/home_page/navigation_screens/consulting_screen/cubit/consulting_cubit.dart';
import 'package:ezdihar_apps/screens/user/home_page/navigation_screens/home_screen/HomePage.dart';
import 'package:ezdihar_apps/screens/user/home_page/navigation_screens/home_screen/cubit/home_page_cubit.dart';
import 'package:ezdihar_apps/screens/user/home_page/navigation_screens/main_screen/cubit/main_page_cubit.dart';
import 'package:ezdihar_apps/screens/user/home_page/navigation_screens/more_screen/cubit/more_cubit.dart';
import 'package:ezdihar_apps/screens/user/home_page/navigation_screens/service_screen/cubit/services_cubit.dart';
import 'package:ezdihar_apps/screens/user/investment_details_screen/investment_details_screen.dart';
import 'package:ezdihar_apps/screens/user/offer_screen/offer_screen.dart';
import 'package:ezdihar_apps/screens/profile_screens/user_profile_screen/cubit/user_profile_cubit.dart';
import 'package:ezdihar_apps/screens/profile_screens/user_profile_screen/user_profile_screen.dart';
import 'package:ezdihar_apps/screens/user/request_consultation_screen/cubit/request_consultation_cubit.dart';
import 'package:ezdihar_apps/screens/user/request_consultation_screen/request_consultation_screen.dart';
import 'package:ezdihar_apps/screens/user/send_general_study_screen/cubit/send_general_study_cubit.dart';
import 'package:ezdihar_apps/screens/user/send_general_study_screen/send_general_study_screen.dart';
import 'package:ezdihar_apps/screens/settings_screen/cubit/setting_cubit.dart';
import 'package:ezdihar_apps/screens/settings_screen/setting_screen.dart';
import 'package:ezdihar_apps/screens/splashPage/splash_page.dart';
import 'package:ezdihar_apps/screens/user/sub_services/cubit/sub_services_cubit.dart';
import 'package:ezdihar_apps/screens/user/sub_services/sub_services_screen.dart';
import 'package:ezdihar_apps/screens/wallet_screen/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/chat_model.dart';
import '../models/user.dart';
import '../screens/payment_screen/payment_page.dart';
import '../screens/provider/control_services/cubit/control_services_cubit.dart';
import '../screens/provider/control_services/screens/control_services.dart';
import '../screens/provider/home_screen/cubit/provider_home_page_cubit.dart';
import '../screens/provider/navigation_bottom/cubit/navigator_bottom_cubit.dart';
import '../screens/provider/navigation_bottom/screens/navigation_bottom.dart';
import '../screens/provider/provider_orders/presentation/cubit/orders_cubit.dart';
import '../screens/provider/provider_orders/presentation/screens/Order_Screen.dart';
import '../screens/provider/service_request/cubit/service_request_cubit.dart';
import '../screens/provider/service_request/screens/service_request.dart';
import '../screens/splashPage/cubit/splash_cubit.dart';
import '../screens/wallet_screen/cubit/wallet_cubit.dart';

class AppRoutes {
  static late HomePageCubit homePageCubit;
  static late MainPageCubit mainPageCubit;
  static late ConsultingCubit consultingCubit;
  static late ServicesCubit servicesCubit;
  static late SubServicesCubit subServicesCubit;

  static late UserProfileCubit userProfileCubit;

  static Route<dynamic>? getRoutes(RouteSettings settings) {
    print('ROUTENAME${settings.name}');
    switch (settings.name) {
      case AppConstant.pageSplashRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<SplashCubit>(
            create: (context) => SplashCubit(),
            child: SplashPage(),
          ),
        );

      case AppConstant.pageHomeRoute:
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<HomePageCubit>(create: (context) {
                  homePageCubit = HomePageCubit();
                  return homePageCubit;
                }),
                BlocProvider<MainPageCubit>(create: (context) {
                  mainPageCubit = MainPageCubit();
                  return mainPageCubit;
                }),
                BlocProvider<ConsultingCubit>(create: (context) {
                  consultingCubit = ConsultingCubit();
                  return consultingCubit;
                }),
                BlocProvider<ServicesCubit>(create: (context) {
                  servicesCubit = ServicesCubit();
                  return servicesCubit;
                }),
                BlocProvider<MoreCubit>(create: (context) => MoreCubit())
              ],
              child: const HomePage(),
            );
          },
        );
      case AppConstant.pageSettingRoute:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => SettingCubit(),
                    ),
                    BlocProvider<NavigatorBottomCubit>(
                      create: (context) => NavigatorBottomCubit(),
                    ),
                    BlocProvider<ControlServicesCubit>(
                      create: (context) => ControlServicesCubit(),
                    ),
                  ],
                  child: SettingPage(),
                ));

      case AppConstant.pageAddRoute:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<AddScreenCubit>(
                      create: (context) => AddScreenCubit()),
                  BlocProvider<FeasibilityCubit>(
                      create: (context) => FeasibilityCubit()),
                ], child: AddPage()));

      case AppConstant.pageInvestmentDetailsRoute:
        return MaterialPageRoute(
            builder: (context) => const InvestmentDetailsPage());
      case AppConstant.pageAccountingConsultantsRoute:
        ConsultantTypeModel consultantTypeModel =
            settings.arguments as ConsultantTypeModel;
        return MaterialPageRoute(
            builder: (context) => AccountingConsultantsPage(
                  consultantTypeModel: consultantTypeModel,
                ));

      case AppConstant.pageOfferRoute:
        return MaterialPageRoute(builder: (context) => const OfferPage());

      case AppConstant.pageWalletRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (BuildContext context) => WalletCubit(),
                child: const WalletPage()));

      case AppConstant.pageContactUsRoute:
        return MaterialPageRoute(
          builder: (context) => const ContactUsPage(),
        );
      case AppConstant.pageConsultantDetailsRoute:
        int consultant_id = settings.arguments as int;

        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ConsultantDetailsCubit(),
                  child: ConsultantDetailsPage(
                    consultant_id: consultant_id,
                  ),
                ));
      case AppConstant.pageRequestConsultationRoute:
        UserModel userModel = settings.arguments as UserModel;

        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => RequestConsultationCubit(),
                  child: RequestConsultationPage(
                    userModel: userModel,
                  ),
                ));
      case AppConstant.pageSendGeneralStudyRoute:
        CategoryModel model = settings.arguments as CategoryModel;
        return MaterialPageRoute(builder: (BuildContext context) {
          return BlocProvider<SendGeneralStudyCubit>(
            create: (context) => SendGeneralStudyCubit(),
            child: SendGeneralStudyScreen(
              model: model,
            ),
          );
        });
      case AppConstant.pageLoginRoute:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider<LoginCubit>(
            create: (context) {
              LoginCubit cubit = LoginCubit();
              return cubit;
            },
            child: LoginPage(),
          );
        });

      case AppConstant.pageUserRoleRoute:
        LoginModel loginModel = settings.arguments as LoginModel;
        return MaterialPageRoute(builder: (context) {
          return BlocProvider<UserRoleCubit>(
            create: (context) => UserRoleCubit(),
            child: UserRolePage(
              loginModel: loginModel,
            ),
          );
        });
      case AppConstant.pageUserSignUpRoleRoute:
        LoginModel loginModel = settings.arguments as LoginModel;
        return MaterialPageRoute(builder: (context) {
          return BlocProvider<UserSignUpCubit>(
            create: (context) => UserSignUpCubit(),
            child: UserSignUpPage(
              loginModel: loginModel,
            ),
          );
        });

      case AppConstant.pageInvestorSignUpRoleRoute:
        User user = settings.arguments as User;
        return MaterialPageRoute(builder: (context) {
          return BlocProvider<InvestorCubit>(
            create: (context) => InvestorCubit(),
            child: InvestorSignUpPage(
              user: user,
            ),
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
      case AppConstant.pageCategoryRoute:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider<CategoryCubit>(
            create: (context) => CategoryCubit(),
            child: CategoryPage(),
          );
        });
      case AppConstant.pageUserProfileRoute:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider<UserProfileCubit>(
            create: (context) {
              userProfileCubit = UserProfileCubit();
              return userProfileCubit;
            },
            child: UserProfilePage(),
          );
        });
      case AppConstant.pageSubCategorieRoute:
        CategoryModel categoryModel = settings.arguments as CategoryModel;

        return MaterialPageRoute(
            builder: (context) => SubServicesPage(
                  categoryModel: categoryModel,
                ));
      case AppConstant.pageAccountingbySubCategoryConsultantsRoute:
        CategoryModel categoryModel = settings.arguments as CategoryModel;
        return MaterialPageRoute(
            builder: (context) => AccountingConsultantsBySubCategoryPage(
                  categoryModel: categoryModel,
                ));

      case AppConstant.pageProviderDetailsRoute:
        User userModel = settings.arguments as User;

        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ProviderDetailsCubit(),
                  child: ProviderDetailsPage(
                    userModel: userModel,
                  ),
                ));

      case AppConstant.pagePaymentRoute:
        String url = settings.arguments as String;

        return MaterialPageRoute(
            builder: (context) => paymetPage(
                  url: url,
                ));
      case AppConstant.pageChatRoute:
        ChatModel chatModel = settings.arguments as ChatModel;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ChatCubit(),
                  child: ChatPage(
                    chatModel: chatModel,
                  ),
                ));

      //Yehiaaaaaaaaaaaaaaaa
      case AppConstant.providerNavigationBottomRoute:
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<ProviderHomePageCubit>(
                  create: (context) => ProviderHomePageCubit(),
                ),
                BlocProvider<NavigatorBottomCubit>(
                  create: (context) => NavigatorBottomCubit(),
                ),
                BlocProvider(
                  create: (context) => SettingCubit(),
                  // child: SettingPage(),
                ),
                BlocProvider(
                  create: (context) => ChatCubit(),
                  // child: SettingPage(),
                ),
                BlocProvider(
                  create: (context) => OrdersCubit(),
                  child: OrderScreen(),
                ),
                BlocProvider<ControlServicesCubit>(
                  create: (context) => ControlServicesCubit(),
                  child: ControlServices(),
                ),
              ],
              child: NavigationBottom(),
            );
          },
        );

      case AppConstant.pageControlServicesRoute:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<ControlServicesCubit>(
              create: (context) => ControlServicesCubit(),
              child: ControlServices(),
            );
          },
        );
        case AppConstant.serviceRequestScreenRoute:
          ChatModel chatModel = settings.arguments as ChatModel;
          return MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => ServiceRequestCubit(),
                child: ServiceRequestScreen(
                  chatModel: chatModel,
                ),
              ));    }
  }
}
