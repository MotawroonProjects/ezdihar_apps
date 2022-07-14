import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/screens/add_screen/navigation_screens/investment_screen/widgets/investment_screen_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../colors/colors.dart';

class InvestmentPage extends StatefulWidget {
  const InvestmentPage({Key? key}) : super(key: key);

  @override
  State<InvestmentPage> createState() => _InvestmentPageState();
}

class _InvestmentPageState extends State<InvestmentPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grey3,
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppColors.colorPrimary,
        child: ListView.builder(
            itemCount: 3,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return const InvestmentScreenWidgets().buildListItem(
                  context: context,
                  object: Object(),
                  index: index,
                  onTaped: _onTaped);
            }),
      ),
    );
  }

  void _onTaped({required Object object, required int index}) {
    Navigator.pushNamed(context, AppConstant.pageInvestmentDetailsRoute);
  }

  Future<void> _onRefresh() async {}
}
