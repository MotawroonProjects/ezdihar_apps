import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../colors/colors.dart';

class LongText extends StatelessWidget {
  const LongText({Key? key, required this.text}) : super(key: key);
final String text;
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding:
      const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      width: MediaQuery.of(context).size.width,
      child:  HtmlWidget(
        text,
        textStyle:  TextStyle(fontSize: 12,color: AppColors.grey1),
      ),
    );

  }
}
