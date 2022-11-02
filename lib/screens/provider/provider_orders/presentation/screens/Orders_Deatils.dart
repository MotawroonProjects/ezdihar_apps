import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/snackbar_method.dart';
import '../../../../../models/provider_order.dart';
import '../../../../../widgets/app_widgets.dart';
import '../../../navigation_bottom/cubit/navigator_bottom_cubit.dart';
import '../cubit/orders_cubit.dart';
import '../widgets/order_details_body_widget.dart';

class OrdersDetails extends StatelessWidget {
  static const String routeName = 'Details';
  final ProviderOrder mainOrdersModel;

  OrdersDetails({required this.mainOrdersModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF5F5F5),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color(0XFF282828),
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'orders_details'.tr(),
          style: TextStyle(
              color: Color(0XFF282828),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocProvider<OrdersCubit>(
        create: (context) => OrdersCubit(),
        child: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            if (state is OrderChangeStatusLoading) {
              // AppWidget.createProgressDialog(context, "wait".tr());
              print("تحمييييييل اقسم بالله ");
              // snackBar("wait".tr(),context,color: AppColors.success);
              return Center(child: CircularProgressIndicator());
            }
            if (state is OrderChangeStatusDone) {
              Navigator.of(context).pop();
              // snackBar("Done",context,color: AppColors.success);
              print("تم يا باااااااااااااشاااااااااااا");
              print("state.statusResponse.message");
              print(state.statusResponse.message);
              print("state.statusResponse.code");
              print(state.statusResponse.code);
            }
            return orderDetailsBodyWidget(mainOrdersModel: mainOrdersModel);
          },
        ),
      ),
    );
  }
}
