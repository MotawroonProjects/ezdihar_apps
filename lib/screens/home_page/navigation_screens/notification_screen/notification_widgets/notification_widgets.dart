import 'package:ezdihar_apps/colors/colors.dart';
import 'package:flutter/material.dart';

class NotificationWidgets {
  Widget buildListItem(
      {required BuildContext context,
      required Object object,
      required int index,
      required Function onTaped}) {

    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                'Notification title',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14.0),
              )),
              Text(
                '5 min ago',
                style: const TextStyle(fontSize: 12.0),
              )
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            'that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English',
            style: const TextStyle(fontSize: 14.0, color: AppColors.grey1),
          ),
          const SizedBox(
            height: 8.0,
          ),
           SizedBox(
            height: 1.0,
            width: width,
            child:
                const DecoratedBox(decoration: BoxDecoration(color: AppColors.grey4)),
          ),
        ],
      ),
    );
  }
}
