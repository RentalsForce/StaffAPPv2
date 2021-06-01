import 'package:bn_staff/core/colors.dart';
import 'package:flutter/material.dart';

class PElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isApiInProgress;
  final Color color;

  PElevatedButton(
      {@required this.text,
      @required this.onPressed,
      this.isApiInProgress = false,
      this.color = PColors.blue});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(this.color),
      ),
      onPressed: isApiInProgress ? () {} : onPressed,
      child: isApiInProgress
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Loading'),
                SizedBox(width: 8),
                SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                    strokeWidth: 3,
                  ),
                ),
              ],
            )
          : Text(text),
    );
  }
}
