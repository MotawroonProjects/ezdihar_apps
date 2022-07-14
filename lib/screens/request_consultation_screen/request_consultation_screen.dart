import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/screens/request_consultation_screen/cubit/request_consultation_cubit.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RequestConsultationPage extends StatefulWidget {
  const RequestConsultationPage({Key? key}) : super(key: key);

  @override
  State<RequestConsultationPage> createState() =>
      _RequestConsultationPageState();
}

class _RequestConsultationPageState extends State<RequestConsultationPage> {
  RequestConsultationCubit cubit = RequestConsultationCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'requestConsultation'.tr(),
          style: const TextStyle(
              color: AppColors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
        leading: AppWidget.buildBackArrow(context: context),
      ),
      backgroundColor: AppColors.grey3,
      body: _buildBodySection(context: context),
    );
  }

  _buildBodySection({required BuildContext context}) {
    double width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<RequestConsultationCubit, RequestConsultantState>(
        builder: (context, state) {
          bool isValid = false;
          if (state is OnDataValid) {
            isValid = true;
          } else {
            isValid = false;
          }
          return Column(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    _buildProfileSection(),
                    _buildFormSection(),
                  ],
                ),
              ),
              InkWell(
                onTap: isValid
                    ? () {
                        _openSheet(context: context,object: Object());
                      }
                    : null,
                child: Container(
                  width: width,
                  height: 56.0,
                  decoration: BoxDecoration(
                      color: isValid ? AppColors.colorPrimary : AppColors.grey4,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0))),
                  child: Center(
                      child: Text(
                    'send'.tr(),
                    style:
                        const TextStyle(fontSize: 16.0, color: AppColors.white),
                  )),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  _buildProfileSection() {
    return Card(
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      elevation: 1.0,
      margin: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppWidget.circleAvatar(144.0, 144.0),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              'Emad Magdy',
              style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              'Accounting Consultants',
              style: const TextStyle(
                  fontSize: 12.0, color: AppColors.colorPrimary),
            ),
            const SizedBox(
              height: 8.0,
            ),
            _buildRateBar(rate: 4),
          ],
        ),
      ),
    );
  }

  _buildFormSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppWidget.svg('project.svg', AppColors.colorPrimary, 24.0, 24.0),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                'projectName'.tr(),
                style: const TextStyle(fontSize: 16.0, color: AppColors.black),
              )
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Container(
              height: 56.0,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.0)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextFormField(
                  initialValue: cubit.model.projectName,
                  maxLines: 1,
                  autofocus: false,
                  onChanged: (text) {
                    cubit.model.projectName = text;
                    cubit.checkData();
                  },
                  cursorColor: AppColors.colorPrimary,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'projectName'.tr(),
                      hintStyle: const TextStyle(
                          color: AppColors.grey1, fontSize: 14.0)),
                ),
              )),
          const SizedBox(
            height: 24.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppWidget.svg('subject.svg', AppColors.colorPrimary, 24.0, 24.0),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                'details'.tr(),
                style: const TextStyle(fontSize: 16.0, color: AppColors.black),
              )
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Container(
              height: 176.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.0)),
              child: TextFormField(
                initialValue: cubit.model.details,
                maxLines: null,
                minLines: null,
                expands: true,
                autofocus: false,
                onChanged: (text) {
                  cubit.model.details = text;
                  cubit.checkData();
                },
                cursorColor: AppColors.colorPrimary,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'writeHere'.tr(),
                    hintStyle: const TextStyle(
                        color: AppColors.grey1, fontSize: 14.0)),
              )),
        ],
      )),
    );
  }

  _buildRateBar({required double rate}) {
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

  _openSheet({required BuildContext context,required Object object}) {
    showModalBottomSheet(
        enableDrag: true,
        isScrollControlled: true,
        elevation: 8.0,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24.0),
                topLeft: Radius.circular(24.0))),
        context: context, builder:(context){
      return Container(
        padding: const EdgeInsets.only(top: 24.0,bottom: 36.0,left: 36.0,right: 36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text.rich(TextSpan(
              text: 'doYouWantToConfirmDeduct'.tr(),
              style:
              const TextStyle(fontSize: 16.0, color: AppColors.black),
              children: [
                TextSpan(
                  text: ' 100',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.colorPrimary),
                  children: [
                    TextSpan(
                        text: ' ${'sar'.tr()} ',
                        style: TextStyle(
                            fontSize: 12.0, color: AppColors.grey1)),
                  ],
                ),
                TextSpan(
                    text: 'fromYourWalletBalance'.tr(),
                    style:
                    TextStyle(fontSize: 16.0, color: AppColors.black)),
              ],
            )),
            const SizedBox(height: 24.0,),
            Row(
              children: [
                Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                      child: Container(
                        height: 48.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.transparent,
                            borderRadius: BorderRadius.circular(8.0),
                            border:
                            Border.all(color: AppColors.color1, width: 1.0)),
                        child: Text(
                          'cancel'.tr(),
                          style: const TextStyle(
                              fontSize: 16.0, color: AppColors.color1),
                        ),
                      ),
                    )),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                      child: Container(
                        height: 48.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.colorPrimary,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'confirm'.tr(),
                          style: const TextStyle(
                              fontSize: 16.0, color: AppColors.white),
                        ),
                      ),
                    )),
              ],
            ),

          ],
        ),
      );
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    FocusManager.instance.primaryFocus!.unfocus();
  }
}
