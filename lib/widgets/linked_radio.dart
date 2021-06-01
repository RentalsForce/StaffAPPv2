import 'package:bn_staff/core/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LinkedLabelRadio extends StatelessWidget {
   LinkedLabelRadio({
    this.label,
    this.padding,
    this.groupValue,
    this.value = false,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: <Widget>[
          Radio<bool>(
              groupValue: groupValue,
              value: value,

              onChanged: (bool newValue) {
                print(value);
                if (value == null) {
                  value = true;
                }
                else{
                  value = !value;
                }                this.onChanged(value);
                print(value);
              },),
          RichText(
            text: TextSpan(
              text: label,
              style: const TextStyle(
                color: PColors.darkBlue,
                fontSize: 16, //background: rgba(79, 85, 102, 1);
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                print('Tapped');

                print(value);
                if (value == null) {
                  value = true;
                }
                else{
                  value = !value;
                }

                this.onChanged(value);
                print(value);

                },
            ),
          ),
        ],
      ),
    );
  }
}
