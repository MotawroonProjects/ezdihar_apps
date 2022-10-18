import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/constants/asset_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../colors/colors.dart';
import '../../../../constants/app_constant.dart';
import '../../../../models/chat_model.dart';
import '../../../../models/user_model.dart';
import '../../../../preferences/preferences.dart';
import '../../../../widgets/app_widgets.dart';
import '../../../../widgets/custom_textfield.dart';
import '../cubit/service_request_cubit.dart';

class ServiceRequestScreen extends StatefulWidget {
  final ChatModel chatModel;

  const ServiceRequestScreen({Key? key, required this.chatModel})
      : super(key: key);

  @override
  State<ServiceRequestScreen> createState() =>
      _ServiceRequestState(chatModel: chatModel);
}

class _ServiceRequestState extends State<ServiceRequestScreen> {
  ChatModel chatModel;

  _ServiceRequestState({required this.chatModel});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    ServiceRequestCubit cubit = BlocProvider.of<ServiceRequestCubit>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'serviceRequest'.tr(),
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<ServiceRequestCubit, ServiceRequestState>(
        builder: (context, state) {
          return ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            children: [
              const SizedBox(
                height: 16.0,
              ),

              Row(
                children: [
                  SvgPicture.asset(
                    AppConstant.localImagePath + 'wallet2.svg',
                    color: AppColors.colorPrimary,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "servicePrice".tr(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Flexible(
                  child: buildTextFormField(
                      hint: 'price'.tr(),
                      inputType: TextInputType.number,
                      action: 'price')),
              const SizedBox(
                height: 24.0,
              ),
              buildRow(icon: 'calender.svg', title: 'delivery_date'.tr()),
              SizedBox(
                height: 8.0,
              ),
              buildTextDate(context),
              const SizedBox(
                height: 24.0,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    AppConstant.localImagePath + 'subject.svg',
                    color: AppColors.colorPrimary,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "details".tr(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Flexible(
                  child: buildTextFormField(
                      hint: 'detials'.tr(),
                      inputType: TextInputType.text,
                      action: 'detials')),
              const SizedBox(
                height: 52.0,
              ),
              buildButtonStart(),
              // ElevatedButton(
              //     style: ButtonStyle(
              //       fixedSize: MaterialStateProperty.all(Size(width, 56.0)),
              //       elevation: MaterialStateProperty.all(2.0),
              //       shape: MaterialStateProperty.all(RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(8.0))),
              //       backgroundColor:
              //       MaterialStateProperty.all(AppColors.colorPrimary),
              //     ),
              //     onPressed: () {
              //       if (cubit.isDataValid) {
              //         // context.read<ContactUsCubit>().send();
              //       }
              //     },
              //     child: Text(
              //       'send'.tr(),
              //       style: const TextStyle(
              //           fontSize: 16.0, color: AppColors.white),
              //     )),
              const SizedBox(
                height: 16.0,
              ),
            ],
          );
        },
      ),
    );
  }

  buildRow({required String icon, required String title}) {
    return Row(
      children: [
        AppWidget.svg(icon, AppColors.colorPrimary, 24.0, 24.0),
        SizedBox(
          width: 8.0,
        ),
        Text(
          title,
          style: TextStyle(color: AppColors.black, fontSize: 16.0),
        )
      ],
    );
  }

  buildTextDate(context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        showBirthDateCalender(context);
      },
      child: Container(
        width: width,
        height: 54.0,
        alignment: lang == 'ar' ? Alignment.centerRight : Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(8)),
        child: BlocBuilder<ServiceRequestCubit, ServiceRequestState>(
          builder: (context, state) {
            String date =
                BlocProvider.of<ServiceRequestCubit>(context).birthDate;
            if (state is UserBirthDateSelected) {
              date = state.date;
            }
            return Text(
              date,
              style: TextStyle(
                  fontSize: 16.0,
                  color:
                      date == 'YYYY-MM-DD' ? AppColors.grey6 : AppColors.black),
            );
          },
        ),
      ),
    );
  }

  showBirthDateCalender(context) async {
    DateTime? date = await showDatePicker(
        context: context,
        locale: EasyLocalization.of(context)!.locale,
        initialDate: BlocProvider.of<ServiceRequestCubit>(context).initialDate,
        firstDate: BlocProvider.of<ServiceRequestCubit>(context).startData,
        lastDate: BlocProvider.of<ServiceRequestCubit>(context).endData,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                    primary: AppColors.colorPrimary,
                    onPrimary: AppColors.white,
                    onSurface: AppColors.black)),
            child: child!,
          );
        });

    if (date != null) {
      BlocProvider.of<ServiceRequestCubit>(context)
          .updateBirthDate(date: DateFormat('yyyy-MM-dd').format(date));
    }
  }

  buildButtonStart() {
    ServiceRequestCubit cubit = BlocProvider.of<ServiceRequestCubit>(context);
   return  BlocListener<ServiceRequestCubit, ServiceRequestState>(listener: (context, state) {


      if(state is OnError){
        Fluttertoast.showToast(
            msg: state.error,  // message
            toastLength: Toast.LENGTH_SHORT, // length
            gravity: ToastGravity.BOTTOM,    // location
            timeInSecForIosWeb: 1               // duration
        );
      }
      else if(state is OnOrderSuccess){
        Navigator.pop(context);
      }},

         child:

         BlocBuilder<ServiceRequestCubit, ServiceRequestState>(
      builder: (context, state) {
        bool isValid = cubit.isDataValid;
        if (state is UserDataValidation) {
          isValid = state.valid;
        }

        return Expanded(
            child: MaterialButton(
          onPressed: isValid
              ? () async {
                  cubit.sendOrder(context, chatModel);
                }
              : null,
          height: 56.0,
          color: AppColors.colorPrimary,
          disabledColor: AppColors.grey4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Text(
            'send'.tr(),
            style: TextStyle(fontSize: 16.0, color: AppColors.white),
          ),
        ));
      },
    ));
  }

  buildTextFormField(
      {required String hint,
      required TextInputType inputType,
      required action}) {
    ServiceRequestCubit cubit = BlocProvider.of<ServiceRequestCubit>(context);
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: hint.contains("price") ? 54.0 : 200,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        keyboardType: inputType,
        style: TextStyle(color: AppColors.black, fontSize: 14.0),
        onChanged: (data) {
          if (action == 'price') {
      cubit.serviceRequestModel.price = data;
          } else if (action == 'detials') {
            cubit.serviceRequestModel.detials = data;
          }
          cubit.checkData();
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(fontSize: 14.0, color: AppColors.grey6),
        ),
      ),
    );
  }
}
