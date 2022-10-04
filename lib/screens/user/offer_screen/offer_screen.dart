import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'cubit/offer_page_cubit.dart';

class OfferPage extends StatefulWidget {
  const OfferPage({Key? key}) : super(key: key);

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  OfferPageCubit cubit = OfferPageCubit();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'offer'.tr(),
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
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<OfferPageCubit, OfferPageState>(
        builder: (context, state) {
          bool isValid = false;
          if (state is OnDataValid) {
            isValid = true;

          }
          return Form(
              child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppWidget.svg(
                              'amount.svg', AppColors.colorPrimary, 24.0, 24.0),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            'paidAmount'.tr(),
                            style: const TextStyle(
                                fontSize: 16.0, color: AppColors.black),
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: TextFormField(
                                  initialValue: cubit.model.amount,

                                  maxLines: 1,
                                  autofocus: false,
                                  onChanged: (text) {
                                    cubit.model.amount=text;
                                    cubit.checkData();
                                  },
                                  cursorColor: AppColors.colorPrimary,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'example_1000'.tr(),
                                      hintStyle: const TextStyle(
                                          color: AppColors.grey1,
                                          fontSize: 14.0)),
                                ),
                              )),
                              Container(
                                width: 56.0,
                                height: 56.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppColors.grey5,
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: Text(
                                  'sar'.tr(),
                                  style: const TextStyle(
                                      color: AppColors.grey1,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppWidget.svg('percentage.svg',
                              AppColors.colorPrimary, 24.0, 24.0),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            'requiredPercentage'.tr(),
                            style: const TextStyle(
                                fontSize: 16.0, color: AppColors.black),
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: TextFormField(
                                  initialValue: cubit.model.percentage,
                                  maxLines: 1,
                                  autofocus: false,
                                  onChanged: (text) {
                                    cubit.model.percentage=text;
                                    cubit.checkData();
                                  },
                                  cursorColor: AppColors.colorPrimary,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'example_1000'.tr(),
                                      hintStyle: const TextStyle(
                                          color: AppColors.grey1,
                                          fontSize: 14.0)),
                                ),
                              )),
                              Container(
                                width: 48.0,
                                height: 56.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppColors.grey5,
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: const Text(
                                  '%',
                                  style: TextStyle(
                                      color: AppColors.grey1,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppWidget.svg('advantage.svg', AppColors.colorPrimary,
                              24.0, 24.0),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            'advantages'.tr(),
                            style: const TextStyle(
                                fontSize: 16.0, color: AppColors.black),
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
                            initialValue: cubit.model.advantage,
                            maxLines: null,
                            minLines: null,
                            expands: true,
                            autofocus: false,
                            onChanged: (text) {
                              cubit.model.advantage=text;
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
                      const SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppWidget.svg('location.svg', AppColors.colorPrimary,
                              24.0, 24.0),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            'location'.tr(),
                            style: const TextStyle(
                                fontSize: 16.0, color: AppColors.black),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Container(
                          height: 56.0,
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(16.0)),
                          child: Text(
                            'location'.tr(),
                            style: const TextStyle(
                                fontSize: 14.0, color: AppColors.grey1),
                          )),
                      const SizedBox(
                        height: 24.0,
                      ),
                      _buildActionTypes(state: state)
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: isValid?(){}:null,
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
                    'sendOffer'.tr(),
                    style:
                        const TextStyle(fontSize: 16.0, color: AppColors.white),
                  )),
                ),
              )
            ],
          ));
        },
      ),
    );
  }

  Widget _buildActionTypes({required OfferPageState state}) {
    bool isNegotiable = cubit.model.isNegotiable;
    bool isInterView = cubit.model.isInterView;
    bool isCall = cubit.model.isVoiceCall;

    if (state is OnNegotiableChanged) {
      isNegotiable = state.isChecked;
    } else if (state is OnInterviewChanged) {
      isInterView = state.isChecked;
    } else if (state is OnCallChanged) {
      isCall = state.isChecked;
    }
    return Card(
      color: AppColors.white,
      elevation: 1.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CheckboxListTile(
              value: isNegotiable,
              onChanged: (checked) {
                cubit.updateNegotiableValue(checked!);
              },
              title: Text(
                'negotiable'.tr(),
                style: const TextStyle(color: AppColors.black, fontSize: 14.0),
              ),
              checkColor: AppColors.white,
              activeColor: AppColors.colorPrimary,
            ),
            AppWidget.buildDashHorizontalLine(context: context),
            CheckboxListTile(
              value: isInterView,
              onChanged: (checked) {
                cubit.updateInterviewValue(checked!);
              },
              title: Text(
                'possibilityInterview'.tr(),
                style: const TextStyle(color: AppColors.black, fontSize: 14.0),
              ),
              checkColor: AppColors.white,
              activeColor: AppColors.colorPrimary,
            ),
            AppWidget.buildDashHorizontalLine(context: context),
            CheckboxListTile(
              value: isCall,
              onChanged: (checked) {
                cubit.updateCallValue(checked!);
              },
              title: Text(
                'voiceCall'.tr(),
                style: const TextStyle(color: AppColors.black, fontSize: 14.0),
              ),
              checkColor: AppColors.white,
              activeColor: AppColors.colorPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
