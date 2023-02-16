import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../colors/colors.dart';
import '../../../../../../constants/app_constant.dart';
import 'custom_button.dart';

class NotLoginPage extends StatelessWidget {
  const NotLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'should_login_text'.tr(),
              style: TextStyle(
                color: AppColors.colorPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Lottie.asset('assets/lottie/login.json'),
            const SizedBox(height: 80),
            CustomButton(
              text: 'login'.tr(),
              paddingHorizontal: 80,
              color: AppColors.colorPrimary,
              onClick: () {
                Navigator.of(context).pushNamed(AppConstant.pageUserRoleRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
