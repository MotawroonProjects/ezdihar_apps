import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../colors/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.grey2,
        child: Center(
            child: Container(
          width: 225.0,
          height: 80.0,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('${AppConstant.localImagePath}logo.png'),
                  fit: BoxFit.cover)),
        )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3)).then((value) => {
      Navigator.of(context).pushReplacementNamed(AppConstant.pageHomeRoute)
    }) ;
  }
}
