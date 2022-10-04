import 'package:flutter/material.dart';

class Bottoms extends StatelessWidget {
  Color color;
  String namedBottom;
  VoidCallback callBack;

  Bottoms(
      {required this.color, required this.namedBottom, required this.callBack});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
      ),
      onPressed: callBack,
      child: Text(
        namedBottom,
        style: TextStyle(fontSize: 17, color: Colors.white),
      ),
    );
  }
}
