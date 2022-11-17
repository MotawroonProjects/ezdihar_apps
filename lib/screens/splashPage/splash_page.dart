import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../colors/colors.dart';
import 'cubit/splash_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is OnUserModelGet) {
          print("state.userModel.user.userType");
          print(state.userModel.user.userType);
          Future.delayed(const Duration(seconds: 2)).then(
                (value) =>
            {
              if(state.userModel.user.userType=='freelancer'){
                Navigator.of(context).pushReplacementNamed(AppConstant.providerNavigationBottomRoute)
              }else{
                Navigator.of(context).pushReplacementNamed(AppConstant.pageHomeRoute)
              }
            },
          );
        } else if (state is NoUserFound) {
          Future.delayed(const Duration(seconds: 2)).then(
                (value) =>
            {
            Navigator.of(context).pushReplacementNamed(AppConstant.pageUserRoleRoute)          },
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            color: AppColors.grey2,
            child: Center(
                child: Container(
                  width: 225.0,
                  height: 80.0,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              '${AppConstant.localImagePath}logo.png'),
                          fit: BoxFit.cover)),
                )),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 3)).then(
    //       (value) =>
    //   {
    //     Navigator.of(context).pushReplacementNamed(AppConstant.pageHomeRoute)
    //   },
    // );
  }
}
