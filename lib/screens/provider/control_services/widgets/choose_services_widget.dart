import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/screens/provider/control_services/widgets/service_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../colors/colors.dart';
import '../../../../models/category_model.dart';
import '../cubit/control_services_cubit.dart';

class ChooseServiceWidget extends StatelessWidget {
  const ChooseServiceWidget({Key? key, required this.categoryModel})
      : super(key: key);
  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;

    context.read<ControlServicesCubit>().Checked(categoryModel);
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: BlocConsumer<ControlServicesCubit, ControlServicesState>(
            listener: (context, state) {
              if(state is NewServiceAdded){
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              return Checkbox(
                  value: context.read<ControlServicesCubit>().newChecked,
                  onChanged: (change) {
                    if (change == true) {
                      showMyEmptyDialog(context,categoryModel);
                      print(change);
                    } else {
                      context
                          .read<ControlServicesCubit>()
                          .model
                          .advisor_category!
                          .forEach((element) {
                        if (element.service!.id == categoryModel.id) {
                          showMyDataDialog(context, element);
                          print(element.price);
                        }
                      });
                    }
                    // print(change);
                  });
            },
          ),
        ),
        Expanded(
          flex: 7,
          child: SizedBox(
            height: 90,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  CachedNetworkImage(
                    imageUrl: categoryModel.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => CircularProgressIndicator(
                      color: AppColors.colorPrimary,
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      size: 46,
                      color: AppColors.colorPrimary,
                    ),
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(lang=='ar'?categoryModel.title_ar:categoryModel.title_en)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
