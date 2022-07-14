import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/service_screen/widgets/service_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneralConsultationPage extends StatefulWidget {
  const GeneralConsultationPage({Key? key}) : super(key: key);

  @override
  State<GeneralConsultationPage> createState() =>
      _GeneralConsultationPageState();
}

class _GeneralConsultationPageState extends State<GeneralConsultationPage> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 8,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            childAspectRatio: 1 / 1.27),
        itemBuilder: (context, index) {
          return InkWell(
            onTap:()=>_onTaped(object: Object(),index: index),
            child: ServiceWidgets()
                .buildListItem(context: context, object: Object(), index: index),
          );
        });
  }

  void _onTaped({required Object object, required int index}) {
     Navigator.pushNamed(context, AppConstant.pageAccountingConsultantsRoute);
  }
}
