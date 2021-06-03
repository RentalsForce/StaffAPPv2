import 'package:bn_staff/core/colors.dart';
import 'package:bn_staff/util/short_methods.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonClose extends StatelessWidget {
  final VoidCallback onTap;
  final String name;

  ButtonClose({this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: PColors.lightBlue,
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 8, top: 4, bottom: 4),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Padding(
              padding:
                   EdgeInsets.only(left: 8, right: 32, top: 8, bottom: 8),
              child: Text(this.name ,
              style: TextStyle(
                color: ShortMethods.giveColor(
                    context, Colors.white, Colors.black)
              ),
              ),
            ),
            GestureDetector(
              onTap: this.onTap,
              child: Icon(FontAwesomeIcons.timesCircle),
            ),
          ],
        ),
      ),
    );
  }
}
