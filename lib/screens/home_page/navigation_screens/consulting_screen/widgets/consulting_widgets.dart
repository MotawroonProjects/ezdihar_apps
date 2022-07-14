import 'package:ezdihar_apps/colors/colors.dart';
import 'package:flutter/material.dart';

class ConsultingWidgets {
  Widget buildListItem(
      {required BuildContext context,
      required Object object,
      required int index}) {
    return Card(
      color: AppColors.white,
      shadowColor: AppColors.grey2,
      elevation: 8.0,
      child:Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.asset(
                'assets/images/test.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
              child: Center(
                child: Text(
                  'Title',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ))
        ],
      )
    );
  }
}
