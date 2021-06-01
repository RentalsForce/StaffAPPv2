import 'package:flutter/material.dart';

class LabeledCheckbox extends StatelessWidget {

  const LabeledCheckbox({
    this.label,
    this.padding,
    this.value,
    this.index,
    this.itemIndex,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final int index;
  final int itemIndex;

  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Text(label , maxLines: 3,),
            Align(
              alignment: Alignment.centerRight,
              child: CheckButton(onChanged: (newValue) {
                print(newValue);
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckButton extends StatefulWidget {
  const CheckButton({
    this.onChanged,
  });

  final Function onChanged;

  @override
  _CheckButtonState createState() => _CheckButtonState();
}

class _CheckButtonState extends State<CheckButton> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (bool newValue) {
        setState(() {
          value = !value;

          widget.onChanged(value);
        });
      },
    );
  }
}
