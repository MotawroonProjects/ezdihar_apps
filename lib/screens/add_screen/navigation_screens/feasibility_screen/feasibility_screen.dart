import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/screens/add_screen/navigation_screens/feasibility_screen/widgets/feasibility_screen_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeasibilityPage extends StatefulWidget {
  const FeasibilityPage({Key? key}) : super(key: key);

  @override
  State<FeasibilityPage> createState() => _FeasibilityPageState();
}

class _FeasibilityPageState extends State<FeasibilityPage> {

  @override
  void initState() {
    super.initState();
    print("initState");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grey3,
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppColors.colorPrimary,
        child: GridView.builder(
            itemCount: 3,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {

              return const FeasibilityScreenWidgets().buildListItem(context: context, object: Object(), index: index, onTaped: _onTaped);
            }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),),
      ),
    );
  }

  void _onTaped({required Object object ,required int index}){
    Navigator.pushNamed(context, AppConstant.pageSendGeneralStudyRoute,arguments: 'ttt');

  }
  Future<void> _onRefresh() async {

  }
}
