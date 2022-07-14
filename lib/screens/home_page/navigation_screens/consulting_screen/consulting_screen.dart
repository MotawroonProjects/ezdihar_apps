import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/consulting_screen/widgets/consulting_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConsultingPage extends StatefulWidget {
  const ConsultingPage({Key? key}) : super(key: key);

  @override
  State<ConsultingPage> createState() => _ConsultingPageState();
}

class _ConsultingPageState extends State<ConsultingPage> {
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
            onTap: ()=>_onTaped(object: Object(), index: index),
              child: ConsultingWidgets().buildListItem(
                  context: context, object: Object(), index: index));
        });
  }

  void _onTaped({required Object object, required int index}) {
    Navigator.pushNamed(context, AppConstant.pageAccountingConsultantsRoute);
  }
}
