import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ConsultantDetailsPage extends StatefulWidget {
  const ConsultantDetailsPage({Key? key}) : super(key: key);

  @override
  State<ConsultantDetailsPage> createState() => _ConsultantDetailsPageState();
}

class _ConsultantDetailsPageState extends State<ConsultantDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'consultantDetails'.tr(),
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
    double width = MediaQuery.of(context).size.width;
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return Column(
      children: [
        Expanded(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                const SizedBox(
                  height: 16.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: AppWidget.circleAvatar(144.0, 144.0),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Emad Magdy',
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Accounting Consultants',
                    style: const TextStyle(
                        fontSize: 12.0, color: AppColors.colorPrimary),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Align(alignment: Alignment.center, child: _buildRateBar(rate: 4)),
                const SizedBox(
                  height: 24.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform.rotate(
                      angle: lang == 'ar' ? 3.14 : 0,
                      child: const SizedBox(
                          width: 12.0,
                          height: 25,
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: AppColors.color1,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12.0),
                                      bottomRight: Radius.circular(12.0))))),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'bio'.tr(),
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                            style: const TextStyle(
                                fontSize: 14.0, color: AppColors.grey1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: AppColors.color4,
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          _buildDetailsSection(svgName: 'offers.svg', title: 'consultationPrice'.tr(), count: "100", content: 'sar'.tr()),
                          _buildDetailsSection(svgName: 'users.svg', title: 'consultations'.tr(), count: "100", content: 'user'.tr())
                        ],
                      ),
                      const SizedBox(height: 24.0,),
                      Row(
                        children: [
                          _buildDetailsSection(svgName: 'job.svg', title: 'yearsExperience'.tr(), count: "8", content: 'years'.tr()),
                          _buildDetailsSection(svgName: 'collage.svg', title: 'graduationRate'.tr(), count: "Excellence", content: '')
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppConstant.pageRequestConsultationRoute);
          },
          child: Container(
            width: width,
            height: 56.0,
            decoration: const BoxDecoration(
                color: AppColors.color1,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0))),
            child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'requestConsultation'.tr(),
                      style:
                      const TextStyle(fontSize: 16.0, color: AppColors.white),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    AppWidget.svg(
                        'question_mark.svg', AppColors.white, 24.0, 24.0)
                  ],
                )),
          ),
        )
      ],
    );
  }

  Widget _buildDetailsSection(
      {required svgName,
      required String title,
      required String count,
      required String content}) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12.0, color: AppColors.grey1),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppWidget.svg(svgName, AppColors.colorPrimary, 24.0, 24.0),
            const SizedBox(
              width: 8.0,
            ),
            RichText(
                text: TextSpan(
                    text: count,
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold,color: AppColors.black),
                    children: [
                  TextSpan(
                      text: content, style: const TextStyle(fontSize: 12.0,color: AppColors.black))
                ]))
          ],
        )
      ],
    ));
  }

  Widget _buildRateBar({required double rate}) {
    return RatingBar.builder(
        itemCount: 5,
        direction: Axis.horizontal,
        itemSize: 22,
        maxRating: 5,
        allowHalfRating: true,
        initialRating: rate,
        tapOnlyMode: false,
        ignoreGestures: true,
        minRating: 0,
        unratedColor: AppColors.grey1,
        itemBuilder: (context, index) {
          return const Icon(
            Icons.star_rate_rounded,
            color: AppColors.colorPrimary,
          );
        },
        onRatingUpdate: (rate) {});
  }
}
