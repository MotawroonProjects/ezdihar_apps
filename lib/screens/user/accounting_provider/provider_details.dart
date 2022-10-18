import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/payment_data.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/screens/user/accounting_provider/cubit/provider_details_cubit.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../models/user.dart';

class ProviderDetailsPage extends StatefulWidget {
  final User userModel;

  ProviderDetailsPage({Key? key, required this.userModel})
      : super(key: key);

  @override
  State<ProviderDetailsPage> createState() =>
      _ProviderDetailsPageState(userModel);
}

class _ProviderDetailsPageState extends State<ProviderDetailsPage> {
User  userModel;
  _ProviderDetailsPageState(this.userModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'providerDetails'.tr(),
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
    ProviderDetailsCubit cubit = BlocProvider.of<ProviderDetailsCubit>(context);
    double width = MediaQuery.of(context).size.width;
    String lang = EasyLocalization.of(context)!.locale.languageCode;
     cubit.getData(userModel.id,userModel.subCategories!.elementAt(0).subCategoryId);

    return BlocListener<ProviderDetailsCubit, ProviderDetailsState>(listener: (context, state) {


    if (state is OnOrderSuccess) {
      PaymentData payment=state.model;
     // print(state.model.payData.transaction.url);
      if(payment.payData!=null){
        Navigator.pushNamed(context, AppConstant.pagePaymentRoute,arguments: payment.payData?.transaction.url);

      }
      else {
        Navigator.pushNamed(context, AppConstant.pageChatRoute,
            arguments: payment.room);
      }
    }},

      child:
      Column(

        children: [
        Expanded(
        child: BlocBuilder<ProviderDetailsCubit, ProviderDetailsState>(
          builder: (context, state) {
            if (state is IsLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.colorPrimary,
                ),
              );
            } else if
            (state is OnError) {
              return Center(
                child: Text(
                  'something_wrong'.tr(),
                  style: TextStyle(fontSize: 15.0, color: AppColors.black),
                ),
              );
            }
            else if (state is OnDataSuccess) {
              OnDataSuccess onSuccess = state as OnDataSuccess;
              UserModel userModel = onSuccess.model;


              return ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(
                      height: 16.0,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: userModel.user.image.isNotEmpty
                          ? CachedNetworkImage(
                        width: 144.0,
                        height: 144.0,
                        imageUrl: userModel.user.image,

                        imageBuilder: (context, imageProvider) =>
                            CircleAvatar(
                              backgroundImage: imageProvider,
                            ),
                        placeholder: (context, url) =>
                            AppWidget.circleAvatar(144.0, 144.0),
                        errorWidget: (context, url, error) =>
                            AppWidget.circleAvatar(144.0, 144.0),
                      )
                          : AppWidget.circleAvatar(144.0, 144.0),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${userModel.user.firstName + " " +
                            userModel.user.lastName}',
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
                        userModel.adviser_data != null
                            ? lang == 'ar'
                            ? userModel
                            .adviser_data!.consultant_type.title_ar
                            : userModel
                            .adviser_data!.consultant_type.title_en
                            : "",
                        style: const TextStyle(
                            fontSize: 12.0, color: AppColors.colorPrimary),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: _buildRateBar(
                            rate: userModel.adviser_data != null
                                ? userModel.adviser_data!.rate
                                : 0)),
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
                                          bottomRight:
                                          Radius.circular(12.0))))),
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
                                '${userModel.adviser_data != null ? userModel
                                    .adviser_data!.bio : ""}',
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
                              _buildDetailsSection(
                                  svgName: 'offers.svg',
                                  title: 'servicePrice'.tr(),
                                  count:
                                  '${userModel.subCategories!=null ? userModel.subCategories!.elementAt(0).price : "0.0"}',
                                  content: 'sar'.tr()),
                              _buildDetailsSection(
                                  svgName: 'users.svg',
                                  title: 'servicenum'.tr(),
                                  count:
                                  '${userModel.adviser_data != null ? userModel
                                      .adviser_data!.count_people : "0"}',
                                  content: 'user'.tr())
                            ],
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          Row(
                            children: [
                              _buildDetailsSection(
                                  svgName: 'job.svg',
                                  title: 'yearsExperience'.tr(),
                                  count:
                                  '${userModel.adviser_data != null ? userModel
                                      .adviser_data!.years_ex : "0"}',
                                  content: 'years'.tr()),
                              _buildDetailsSection(
                                  svgName: 'collage.svg',
                                  title: 'birthdate'.tr(),

                                  content: userModel.user.birthdate, count: '')
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Text(

                          '${lang == 'ar'
                              ? userModel
                              .subCategories!.elementAt(0).descAr
                              : userModel
                              .subCategories!.elementAt(0).descEn}',
                          style: const TextStyle(
                              fontSize: 14.0, color: AppColors.grey1),
                        ))
                  ]
              );
            }

            else {
return Center();
            }
          },
      ))

    ,
    InkWell(
    onTap: () {
     cubit.sendOrder(context,userModel);
    //   Navigator.pushNamed(context, AppConstant.pageRequestConsultationRoute,arguments: cubit.userModel);
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
    'requestserviceNow'.tr(),
    style: const TextStyle(
    fontSize: 16.0, color: AppColors.white),
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

      ));




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
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black),
                    children: [
                  TextSpan(
                      text: content,
                      style: const TextStyle(
                          fontSize: 12.0, color: AppColors.black))
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
