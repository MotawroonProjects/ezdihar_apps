import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/login_model.dart';
import 'package:ezdihar_apps/screens/auth_screens/user_role_screen/cubit/user_role_cubit.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserRolePage extends StatefulWidget {
  LoginModel loginModel;
 UserRolePage({Key? key, required this.loginModel}) : super(key: key);

  @override
  State<UserRolePage> createState() => _UserRolePageState(loginModel);
}

class _UserRolePageState extends State<UserRolePage> {
  LoginModel loginModel;

  _UserRolePageState(this.loginModel);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'sign_up'.tr(),
          style: const TextStyle(
              color: AppColors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
        leading: AppWidget.buildBackArrow(context: context),
      ),
      backgroundColor: AppColors.grey2,
      body: BlocProvider<UserRoleCubit>(
        create: (context) {
          return UserRoleCubit();
        },
        child: buildBodySection(context),
      ),
    );
  }

  buildBodySection(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ListView(
      children: [
        const SizedBox(
          height: 36.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'welcome_to_ezdehar'.tr(),
            style: TextStyle(
                fontSize: 24,
                color: AppColors.colorPrimary,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'select_user_type'.tr(),
            style: TextStyle(fontSize: 18, color: AppColors.grey1),
          ),
        ),
        const SizedBox(
          height: 36.0,
        ),
        BlocBuilder<UserRoleCubit, UserRoleState>(
          builder: (context, state) {
            UserRoleInitial initState = state as UserRoleInitial;
            return buildCardData(
                title: 'user'.tr(),
                content: 'user_content'.tr(),
                image: 'user.png',
                borderWidth:
                    initState.role == AppConstant.role_user ? 2.0 : 0.0,
                role: AppConstant.role_user,
                context: context);
          },
        ),
        BlocBuilder<UserRoleCubit, UserRoleState>(
          builder: (context, state) {
            UserRoleInitial initState = state as UserRoleInitial;

            return buildCardData(
                title: 'consultant'.tr(),
                content: 'consultant_content'.tr(),
                image: 'consultant.png',
                borderWidth:
                    initState.role == AppConstant.role_consultant ? 2.0 : 0.0,
                role: AppConstant.role_consultant,
                context: context);
          },
        ),
        BlocBuilder<UserRoleCubit, UserRoleState>(
          builder: (context, state) {
            UserRoleInitial initState = state as UserRoleInitial;

            return buildCardData(
                title: 'provider'.tr(),
                content: 'investor_content'.tr(),
                image: 'investor.png',
                borderWidth:
                    initState.role == AppConstant.role_investor ? 2.0 : 0.0,
                role: AppConstant.role_investor,
                context: context);
          },
        ),
        const SizedBox(
          height: 36.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocBuilder<UserRoleCubit, UserRoleState>(
            builder: (context, state) {
              UserRoleInitial initState = state as UserRoleInitial;

              return BlocProvider.value(
                value: BlocProvider.of<UserRoleCubit>(context),
                child: MaterialButton(
                  onPressed: initState.role.isNotEmpty
                      ? () {
                          UserRoleCubit cubit =
                              BlocProvider.of<UserRoleCubit>(context);
                          navigateToSignUp(role: cubit.role);
                        }
                      : null,
                  height: 56.0,
                  minWidth: width,
                  disabledColor: AppColors.grey4,
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  color: AppColors.colorPrimary,
                  child: Text('next'.tr(),
                      style: TextStyle(fontSize: 16.0, color: AppColors.white)),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 36.0,
        ),
      ],
    );
  }

  buildCardData(
      {required String title,
      required String content,
      required String image,
      required double borderWidth,
      required String role,
      required BuildContext context}) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    UserRoleCubit cubit = BlocProvider.of<UserRoleCubit>(context);
    return InkWell(
      onTap: () {
        cubit.updateRole(role);
      },
      child: Card(
        color: AppColors.white,
        margin: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: borderWidth > 0
                    ? AppColors.colorPrimary
                    : AppColors.transparent,
                width: borderWidth),
            borderRadius: BorderRadius.circular(16.0)),
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      content,
                      style: TextStyle(fontSize: 14.0, color: AppColors.grey6),
                    ),
                  ],
                ),
              ),
              Transform.scale(
                scaleX: lang == 'ar' ? -1 : 1,
                child: Image.asset(
                  '${AppConstant.localImagePath + image}',
                  width: 112.0,
                  height: 112.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  navigateToSignUp({required String role}) async {
    if (role == AppConstant.role_user) {
      var result = await Navigator.pushNamed(context, AppConstant.pageUserSignUpRoleRoute,arguments: loginModel);
      if(result!=null){
        Navigator.pop(context,true);
      }
    } else if (role == AppConstant.role_investor) {
      var result = await Navigator.pushNamed(context, AppConstant.pageInvestorSignUpRoleRoute);
      if(result!=null){
        Navigator.pop(context,true);
      }
    } else if (role == AppConstant.role_consultant) {
      var result = await Navigator.pushNamed(context, AppConstant.pageConsultantSignUpRoleRoute);
      if(result!=null){
        Navigator.pop(context,true);
      }
    }
  }
}
