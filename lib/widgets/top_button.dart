import 'package:bn_staff/core/colors.dart';
import 'package:flutter/material.dart';


class TopButton extends StatelessWidget {

  final String text;
  final isSelected;
  final VoidCallback onTap;


  const TopButton({
    Key key,
    this.text = '',
    this.isSelected = false,
    this.onTap
  }) : super(key: key);

  //  /
  @override
  Widget build(BuildContext context) {
    return TextButton(

      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? PColors.darkBlue : PColors.lightGray,
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
        ),
        width: 280,
        height: 64,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0,top: 8,bottom: 8,right: 4),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: !isSelected ? PColors.darkBlue : PColors.lightGray,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                width: 30,
                height: 30,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  this.text,
                  style: TextStyle(color: isSelected ? Colors.white : Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
