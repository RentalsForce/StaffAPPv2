import 'package:bn_staff/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class InputView extends StatelessWidget {
  InputView(
      {this.placeHolder,
        this.isSecure = false,
        this.controller,
        this.showError = false,
        this.readOnly = false,
        this.onTap,
        this.numberPicker = false});

  final TextEditingController controller;

  final showError;

  final numberPicker;

  final readOnly;
  final VoidCallback onTap;

  final String placeHolder;
  final bool isSecure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            placeHolder,
            style: showError
                ? Theme.of(context).textTheme.subtitle2
                : Theme.of(context).textTheme.caption,
          ),
          const SizedBox(height: 8),
          if (this.numberPicker && 1 == 1) ...[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color:
                MediaQuery.of(context).platformBrightness == Brightness.dark
                    ? PColors.text_field_background_dark
                    : PColors.text_field_background,
              ),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      int check = int.parse(this.controller.text.toString());
                      check++;
                      this.controller.text = check.toString();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),

                    ),
                  ),
                  Expanded(
                    child: buildTextField(context),
                  ),
                  TextButton(
                    onPressed: () {
                      int check = int.parse(this.controller.text.toString());
                      if (check == 1) {
                        return;
                      }
                      check--;
                      this.controller.text = check.toString();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),

                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            buildTextField(context),
          ]
        ],
      ),
    );
  }

  TextField buildTextField(context) {
    return TextField(
      onTap: () {
        if (this.readOnly) {
          this.onTap.call();
        }
      },
      readOnly: this.readOnly,
      obscureText: this.isSecure,
      controller: controller,
      textAlign: numberPicker ? TextAlign.center : TextAlign.left,
      style: numberPicker
          ? TextStyle(fontSize: 20, fontWeight: FontWeight.w600 ,
          color: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.white
              : Colors.black
      )
          : TextStyle(
          color:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.white
              : Colors.black),
      decoration: InputDecoration(
        hintText: placeHolder,
        hintStyle: TextStyle(color: Colors.white70),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
          ),
        ),
      ),
      // keyboardType: TextInputType.number,
    );
  }
}
