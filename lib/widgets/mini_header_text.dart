import 'package:flutter/material.dart';

class MiniHeaderText extends StatelessWidget {
  final String text;
  MiniHeaderText({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),
    );
    ;
  }
}
