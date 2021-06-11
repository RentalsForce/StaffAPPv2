import 'package:bn_staff/core/colors.dart';
import 'package:bn_staff/util/short_methods.dart';
import 'package:bn_staff/widgets/button_close.dart';
import 'package:bn_staff/widgets/elevated_button.dart';
import 'package:bn_staff/widgets/ink_well.dart';
import 'package:bn_staff/widgets/mini_card.dart';
import 'package:bn_staff/widgets/mini_header_text.dart';
import 'package:bn_staff/widgets/small_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:flutter/material.dart';

import 'add_maintenance_request.dart';

class ReplaceBrokenItem extends StatefulWidget {
  @override
  _ReplaceBrokenItemState createState() => _ReplaceBrokenItemState();
}

class _ReplaceBrokenItemState extends State<ReplaceBrokenItem> {
  int selectedIndex = 0;
  String customIssue;

  final picker = ImagePicker();
  List<File> images = [];

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        // _image = tmpImage;
        images.add(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  Future captureImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        // _image = tmpImage;
        images.add(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  TextEditingController _controller = TextEditingController();
  TextEditingController _nameController = TextEditingController();

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
                text: 'Replace Broken Item',
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
                  isSelected: selectedIndex == 0,
                  name: 'Broken Light Bulb',
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                      _controller.text = '';
                    });
                  },
                  onDeleteTap: () {},
                ),
                ButtonClose(
                  isSelected: selectedIndex == 1,
                  name: 'New Tissues',
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                      _controller.text = '';
                    });
                  },
                  onDeleteTap: () {},
                ),
                if (this.customIssue != null) ...[
                  ButtonClose(
                    isSelected: selectedIndex == 2,
                    name: 'Add Custom Issue',
                    onTap: () {
                      setState(() {
                        selectedIndex = 2;

                        if (customIssue != null) {
                          _controller.text = this.customIssue;
                        }
                      });
                    },
                    onDeleteTap: () {},
                  ),
                ],
              ],
            ),
            SizedBox(
              height: 16,
            ),
            buildText('Broken Item Name'),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: _nameController,
              keyboardType: TextInputType.multiline,
              maxLines: 1,
              style: TextStyle(
                color:
                ShortMethods.giveColor(context, Colors.black, Colors.white),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            buildText('Description of Damage'),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(
                color:
                ShortMethods.giveColor(context, Colors.black, Colors.white),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            buildText('Upload supporting images'),
            SizedBox(
              height: 4,
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {},
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextButton(
                      icon: Icons.camera_alt_outlined,
                      text: 'Capture Image',
                      onTap: () {
                        this.captureImage();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: CustomTextButton(
                      icon: Icons.image_outlined,
                      text: 'Select from Gallery',
                      onTap: () {
                        getImageFromGallery();
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < images.length; i++) ...[
                    SmallImageView(
                      index: i,
                      file: images[i],
                      onDelete: (index) {
                        setState(() {
                          images.removeAt(i);
                        });
                      },
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            PElevatedButton(
              text: 'Add Damage Item',
              onPressed: () {
                FocusManager.instance.primaryFocus.unfocus();

                if (_controller.text.length > 0) {
                  setState(() {
                    this.customIssue = _controller.text;
                    _controller.text = '';
                  });
                }
              },
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



