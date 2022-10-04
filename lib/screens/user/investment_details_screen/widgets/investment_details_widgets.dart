import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class InvestmentDetailsWidgets {
  Widget buildListItem(
      {required BuildContext context,
      required Object object,
      required int index,
      required Function onTaped}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildProgressRate(context: context, progress: .7),
              const SizedBox(width: 8.0,),
              const Expanded(
                child: Text(
                  'Accounting Consultant',
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.color1),
                ),

              ),
              ElevatedButton.icon(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.white)),onPressed: (){},icon:AppWidget.svg('download.svg', AppColors.color1, 16.0, 16.0), label: Text('download'.tr(),style: const TextStyle(color: AppColors.color1,fontSize: 12.0),)
              )
            ],
          ),
          const SizedBox(height: 12.0,),

          AppWidget.buildDashHorizontalLine(context: context)
        ],
      ),
    );
  }

  Widget _buildProgressRate(
      {required BuildContext context, required double progress}) {
    return CircularPercentIndicator(
      radius: 24.0,
      startAngle: 90,
      progressColor: AppColors.colorPrimary,
      animation: true,
      animateFromLastPercent: true,
      percent: progress,
      fillColor: AppColors.white,
      backgroundColor: AppColors.grey3,
      circularStrokeCap: CircularStrokeCap.round,
      lineWidth: 5.0,
      center: Text(
        '${(progress * 100).toInt()}%',
        style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: AppColors.color1),
      ),
    );
  }
}
