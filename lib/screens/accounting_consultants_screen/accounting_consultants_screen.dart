import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/screens/accounting_consultants_screen/widget/accounting_consultants_widgets.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AccountingConsultantsPage extends StatefulWidget {
  const AccountingConsultantsPage({Key? key}) : super(key: key);

  @override
  State<AccountingConsultantsPage> createState() =>
      _AccountingConsultantsPageState();
}

class _AccountingConsultantsPageState extends State<AccountingConsultantsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'accountingConsultants'.tr(),
          style: const TextStyle(
              color: AppColors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
        leading: AppWidget.buildBackArrow(context: context),
      ),
      backgroundColor: AppColors.grey3,
      body: _buildBodySection(),
    );
  }

  Widget _buildBodySection() {
    return ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.vertical,
        itemBuilder: ((context, index) {
          return InkWell(
            onTap: ()=>_onTaped(object: Object(),index: index),
            child: AccountingConsultantsWidgets()
                .buildListItem(context: context,object: Object(), index: index),
          );
        }));
  }
  void _onTaped({required Object object,required int index}){
    Navigator.pushNamed(context, AppConstant.pageConsultantDetailsRoute);
  }
}
