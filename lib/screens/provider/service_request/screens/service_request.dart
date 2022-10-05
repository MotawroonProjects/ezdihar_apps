import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/constants/asset_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../colors/colors.dart';
import '../../../../widgets/app_widgets.dart';
import '../../../../widgets/custom_textfield.dart';
import '../cubit/service_request_cubit.dart';

class ServiceRequestScreen extends StatelessWidget {
   ServiceRequestScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
          child: Column(
            children: [
              const SizedBox(
                height: 16.0,
              ),
              CustomTextField(
                title: "customer_name".tr(),
                image:'id_icon.svg',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24.0,
              ),
              CustomTextField(
                title: "service_type".tr(),
                image: 'control_service.svg',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24.0,
              ),
              CustomTextField(
                title: "servicePrice".tr(),
                image: "wallet2.svg",
                textInputType: TextInputType.number,
              ),
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
              CustomTextField(
                title: "details".tr(),
                image: 'subject.svg',
                textInputType: TextInputType.text,
                minLine: 4,
              ),
              const SizedBox(
                height: 52.0,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(width, 56.0)),
                    elevation: MaterialStateProperty.all(2.0),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0))),
                    backgroundColor:
                    MaterialStateProperty.all(AppColors.colorPrimary),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // context.read<ContactUsCubit>().send();
                    }
                  },
                  child: Text(
                    'send'.tr(),
                    style: const TextStyle(
                        fontSize: 16.0, color: AppColors.white),
                  )),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
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
             String date = BlocProvider.of<ServiceRequestCubit>(context).birthDate;
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

}
