import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/notification_screen/notification_widgets/notification_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../colors/colors.dart';
import '../../../../widgets/app_widgets.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: AppColors.grey2,
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppColors.colorPrimary,
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return NotificationWidgets().buildListItem(
                  context: context,
                  object: Object(),
                  index: index,
                  onTaped: _onTaped);
            }),
      ),
    ));
  }

  void _onTaped({required Object object, required int index}) {}

  Future<void> _onRefresh() async {}
}
