import 'package:bn_staff/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class InputView extends StatelessWidget {
  final String label;
  final String detailLabel;
  final TextInputType textInputType; //TextInputType.number
  final FormFieldValidator formValidations;

  final Function(String) onChange;
  final showError;
  final errorText;
  final icon;

  final isPassword;
  final isSecure;
  TextEditingController controller;

  InputView(
      {this.label,
      this.detailLabel,
      this.textInputType,
      this.formValidations,
      this.onChange,
      this.isSecure = false,
      this.showError ,
        this.isPassword = false,
        this.errorText,
        this.icon,
        this.controller
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextField(
        obscureText: isPassword,
        controller: controller,
        autocorrect: true,
        decoration: InputDecoration(
          hintText: detailLabel,
          prefixIcon: Icon(this.icon),
          errorText:showError ? this.errorText : null,
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white70,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            borderSide: BorderSide(color: PColors.blue, width: 1),
          ),
        ),
      ),
    );
  }
}
