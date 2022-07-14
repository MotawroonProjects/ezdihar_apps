import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/screens/send_general_study_screen/cubit/send_general_study_cubit.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendGeneralStudyScreen extends StatefulWidget {
  final String title;

  const SendGeneralStudyScreen({Key? key, required this.title})
      : super(key: key);

  @override
  State<SendGeneralStudyScreen> createState() =>
      _SendGeneralStudyScreenState(title: title);
}

class _SendGeneralStudyScreenState extends State<SendGeneralStudyScreen> {
  _SendGeneralStudyScreenState({required this.title});

  SendGeneralStudyCubit cubit = SendGeneralStudyCubit();

  final String title;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
              color: AppColors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
        leading: AppWidget.buildBackArrow(context: context),
      ),
      backgroundColor: AppColors.grey3,
      body: BlocProvider(
        create: (context) => cubit,
        child: BlocBuilder<SendGeneralStudyCubit, SendGeneralStudyState>(
          builder: (context, state) {
            bool isValid = false;
            if(state is OnDataValid){
              isValid = true;
            }
            return Column(
              children: [

                _buildBodySection(state),
                InkWell(
                  onTap: isValid ? () {} : null,
                  child: Container(
                    width: width,
                    height: 56.0,
                    decoration: BoxDecoration(
                        color:
                            isValid ? AppColors.colorPrimary : AppColors.grey4,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24.0),
                            topRight: Radius.circular(24.0))),
                    child: Center(
                        child: Text(
                      'send'.tr(),
                      style: const TextStyle(
                          fontSize: 16.0, color: AppColors.white),
                    )),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  _buildBodySection(SendGeneralStudyState state) {
    bool showInvestment = cubit.model.showProjectInvestment;
    if(state is OnShowProjectInvestmentChanged){
      showInvestment = state.isChecked;
    }
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 24.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppWidget.svg(
                    'project.svg', AppColors.colorPrimary, 24.0, 24.0),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  'projectName'.tr(),
                  style:
                      const TextStyle(fontSize: 16.0, color: AppColors.black),
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
                AppWidget.svg(
                    'subject.svg', AppColors.colorPrimary, 24.0, 24.0),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  'details'.tr(),
                  style:
                      const TextStyle(fontSize: 16.0, color: AppColors.black),
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
            const SizedBox(
              height: 24.0,
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.colorPrimary, width: 1.0),
                  color: AppColors.color4,
                  borderRadius: BorderRadius.circular(16.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: showInvestment,
                    onChanged: (checked) {
                      cubit.updateShowProjectInvestment(checked!);
                    },
                    title: Text(
                      'showProjectInvestment'.tr(),
                      style: const TextStyle(color: AppColors.black, fontSize: 14.0),
                    ),
                    checkColor: AppColors.white,
                    activeColor: AppColors.colorPrimary,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppWidget.svg(
                          'feasibility_img.svg', AppColors.colorPrimary, 24.0, 24.0),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'feasibility'.tr(),
                        style:
                        const TextStyle(fontSize: 16.0, color: AppColors.black),
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
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
          ],
        ),
      ),
    ));
  }
}
