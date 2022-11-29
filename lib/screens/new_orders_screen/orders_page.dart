import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/screens/new_orders_screen/cubit/orders_cubit.dart';
import 'package:ezdihar_apps/screens/new_orders_screen/widget/ItemsOrder.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_constant.dart';
import '../../models/chat_model.dart';
import '../../models/provider_order.dart';


class OrdersPage extends StatefulWidget {
  final ChatModel chatModel;

  const OrdersPage({Key? key, required this.chatModel}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState(chatModel: chatModel);
}

class _OrdersPageState extends State<OrdersPage> {
  ChatModel chatModel;
  _OrdersPageState({required this.chatModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'orders'.tr(),
          style: const TextStyle(
              color: AppColors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
        leading: AppWidget.buildBackArrow(context: context),
      ),
      backgroundColor: AppColors.grey2,
      body: buildBodySection(),
    );
  }

  buildBodySection() {
    NewOrdersCubit cubit = BlocProvider.of<NewOrdersCubit>(context);
print("ssss66677s${chatModel.id.toString()}");
    return BlocProvider(

        create: (context) {
      cubit.getChat(chatModel.id.toString());
      return cubit;
    },
      child: BlocBuilder<NewOrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is IsLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.colorPrimary,
            ),
          );
        }
        else if (state is OnDataSuccess) {
          return Column(
            children: [ buildListSection()],
          );
        } else {
          OnError error = state as OnError;
          return InkWell(
            onTap: (){cubit.getChat(chatModel.id.toString());},
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppWidget.svg('reload.svg', AppColors.colorPrimary, 24.0, 24.0),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'reload'.tr(),
                    style:
                        TextStyle(color: AppColors.colorPrimary, fontSize: 15.0),
                  )
                ],
              ),
            ),
          );
        }
      },
    ));
  }


  buildListSection() {

    NewOrdersCubit cubit = BlocProvider.of<NewOrdersCubit>(context);
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return Expanded(
      child: OrderWidget(cubit.list),
    );
  }
  OrderWidget(List<ProviderOrder> list){
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return RefreshIndicator(
      color: AppColors.colorPrimary,
      onRefresh: refreshCurrent,
      child: ListView.builder(
          itemCount: list.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            ProviderOrder model = list[index];
            return InkWell(
              onTap: (){
                Navigator.pushNamed(

                    context,AppConstant.OrdersDetialsScreenRoute,
                    arguments: model).then((value) => {refreshCurrent()});                },
              child: ItemsOrders().buildListItem(
                  context: context, model: model, index: index),



            );
          }),
    );
  }
  Future<void> refreshCurrent() async {
    print("fkfkfkfk");
    NewOrdersCubit cubit = BlocProvider.of<NewOrdersCubit>(context);
    cubit.getChat(chatModel.id.toString());
  }

}
