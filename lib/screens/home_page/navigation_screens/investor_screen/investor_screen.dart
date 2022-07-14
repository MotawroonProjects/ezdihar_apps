import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/investor_screen/investor_widgets/investor_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class InvestorPage extends StatefulWidget {
  const InvestorPage({Key? key}) : super(key: key);

  @override
  State<InvestorPage> createState() => _InvestorPageState();
}

class _InvestorPageState extends State<InvestorPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildListView(context),
    );
  }

  Widget _buildListView(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.colorPrimary,
      onRefresh: refreshData,
      child: ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {

            return InvestorWidgets().buildListItem(context: context, object: Object(), index: index);
          }),
    );
  }

  Future<void> refreshData() async {}

}
