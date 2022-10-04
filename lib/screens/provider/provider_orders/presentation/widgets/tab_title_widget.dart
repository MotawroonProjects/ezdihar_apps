import 'package:flutter/material.dart';

import '../../../../../colors/colors.dart';

class TabTitleWidget extends StatelessWidget {
  const TabTitleWidget({Key? key, required this.text, required this.index}) : super(key: key);
  final String text;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: AppColors.colorPrimary,
        child: Text(text),
      ),
    );
  }
}
