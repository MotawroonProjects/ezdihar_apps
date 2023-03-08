import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../colors/colors.dart';
import '../cubit/orders_cubit.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({Key? key, required this.text, required this.index}) : super(key: key);
final String text;
final int index;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: (){
          context.read<OrdersCubit>().changePage(index);
          // context.read<OrdersCubit>().getProviderNewOrder(context);
        },
        child: Container(
          height: 55,
          color: context.read<OrdersCubit>().page== index
              ? AppColors.colorPrimary
              : null,
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 18,color: context.read<OrdersCubit>().page== index
                  ? AppColors.white
                  : AppColors.black,),
            ),
          ),
        ),
      ),
    );
  }
}
