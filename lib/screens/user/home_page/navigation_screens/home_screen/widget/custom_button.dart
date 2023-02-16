import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.text,
      required this.color,
      required this.onClick,
      this.paddingHorizontal = 0})
      : super(key: key);
  final String text;
  final Color color;
  final double paddingHorizontal;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
            maximumSize: Size.infinite,
            shape: RoundedRectangleBorder(
                //to set border radius to button
                borderRadius: BorderRadius.circular(8)),
            minimumSize: const Size(double.infinity, 60),
            backgroundColor: color),
        child: Text(text),
      ),
    );
  }
}
