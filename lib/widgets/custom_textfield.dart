import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colors/colors.dart';
import '../constants/app_constant.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.image,
    required this.title,
    required this.textInputType,
    this.minLine = 1,
    this.isPassword = false,
    this.validatorMessage = '',
    this.isNum = false,
    this.controller,
    this.imageColor = AppColors.colorPrimary,
    this.imageWidth = 24,
    this.imageHeight = 24,
  }) : super(key: key);
  final String image;
  final Color imageColor;
  final double imageWidth;
  final double imageHeight;
  final String title;
  final String validatorMessage;
  final int minLine;
  final bool isPassword;
  final bool isNum;
  final TextInputType textInputType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Column(
        children: [
          image != "null"
              ?
          Row(
                  children: [
                    SvgPicture.asset(
                      AppConstant.localImagePath + image,
                      color: imageColor,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      title,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                )
              : const SizedBox(width: 0),
          image != "null"
              ? const SizedBox(height: 6)
              : const SizedBox(width: 0),
          TextFormField(
            controller: controller,
            keyboardType: textInputType,
            obscureText: isPassword,
            decoration: InputDecoration(
                hintText: title,
                border: image != "null"
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide.none,
                      )
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                fillColor: AppColors.white,
                filled: true),
            maxLines: isPassword ? 1 : 20,
            minLines: minLine,
            validator: (value) {
              if (value == null || value.isEmpty) {
                if(validatorMessage!="@"){
                  return validatorMessage;
                }else{

                }
              }
              return null;
            },
          )
        ],
      ),
    );
  }
}
