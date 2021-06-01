import 'package:flutter/material.dart';

class PButton extends StatelessWidget {
  final title;
  final VoidCallback action;

  PButton({this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 24,
          child: Container(),
        ),
        Expanded(
          flex: 52,
          child: ElevatedButton(
            onPressed: () {
              this.action.call();
            },
            child: Text(
              this.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 24,
          child: Container(),
        ),
      ],
    );
  }
}
