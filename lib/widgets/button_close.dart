import 'package:bn_staff/core/colors.dart';
import 'package:bn_staff/util/short_methods.dart';
import 'package:bn_staff/widgets/ink_well.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonClose extends StatelessWidget {
  final VoidCallback onDeleteTap;
  final VoidCallback onTap;

  final String name;

  final bool isSelected;

  ButtonClose(
      {this.name, this.onDeleteTap, this.isSelected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return PInkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: isSelected ? PColors.darkBlue : PColors.lightBlue,
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 8, top: 4, bottom: 4),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8, right: 32, top: 8, bottom: 8),
                child: Text(
                  this.name,
                  style: TextStyle(
                      color: ShortMethods.giveColor(
                          context, Colors.white, Colors.black)),
                ),
              ),
              GestureDetector(
                onTap: this.onDeleteTap,
                child: Icon(FontAwesomeIcons.timesCircle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
