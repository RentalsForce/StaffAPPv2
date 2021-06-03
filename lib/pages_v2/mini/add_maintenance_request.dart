import 'package:bn_staff/core/colors.dart';
import 'package:bn_staff/util/short_methods.dart';
import 'package:bn_staff/widgets/button_close.dart';
import 'package:bn_staff/widgets/elevated_button.dart';
import 'package:bn_staff/widgets/mini_card.dart';
import 'package:bn_staff/widgets/mini_header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddMaintenanceRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MiniCard(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.center,
              child: MiniHeaderText(
                text: 'Add Maintenance Request',
              ),
            ),
            SizedBox(
              height: 16,
            ),
            if (2 == 1) ...[
              Text(
                'Add Issues would appear here',
                style: TextStyle(color: PColors.greyTextColor, fontSize: 16),
              ),
              SizedBox(
                height: 16,
              ),
            ],
            Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0,
              children: [
                ButtonClose(
                  name: 'Broken Light Bulb',
                  onTap: () {},
                ),
                ButtonClose(
                  name: 'New Tissues',
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            buildText('Maintenance Issue'),
            SizedBox(
              height: 8,
            ),
            FormBuilderDropdown(
              name: 'gender',
              // initialValue: 'Male',
              dropdownColor: ShortMethods.giveColor(
                  context, Colors.white, Colors.black),
              allowClear: true,
              hint: Text(
                'Select Maintenance Issue',
                style: TextStyle(
                  color: ShortMethods.giveColor(
                      context, Colors.black, Colors.white),
                ),
              ),
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required(context)]),
              items: ['Broken Light Bulb', 'New Tissues']
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(
                          '$gender',
                          style: TextStyle(
                            color: ShortMethods.giveColor(
                                context, Colors.black, Colors.white),
                          ),
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 8,
            ),
            buildText('Detail'),
            SizedBox(
              height: 8,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(
                color:
                    ShortMethods.giveColor(context, Colors.black, Colors.white),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            PElevatedButton(
              text: 'Add Issue',
              onPressed: () {},
              color: Color.fromRGBO(67, 128, 177, 1),
//background: rgba(67, 128, 177, 1);
            ),
            SizedBox(
              height: 28,
            ),
            PElevatedButton(
              text: 'Save',
              onPressed: () {
                Navigator.pop(context);
              },
//background: rgba(67, 128, 177, 1);
            ),
          ],
        ),
      ),
    );
  }

  Text buildText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
      ),
    );
  }
}
