import 'package:bn_staff/core/colors.dart';
import 'package:bn_staff/model/room.dart';
import 'package:bn_staff/model/room_detail.dart';
import 'package:bn_staff/util/dialog_utils.dart';
import 'package:bn_staff/util/dio.dart';
import 'package:bn_staff/util/short_methods.dart';
import 'package:bn_staff/widgets/button_close.dart';
import 'package:bn_staff/widgets/elevated_button.dart';
import 'package:bn_staff/widgets/ink_well.dart';
import 'package:bn_staff/widgets/mini_card.dart';
import 'package:bn_staff/widgets/mini_header_text.dart';
import 'package:bn_staff/widgets/small_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:flutter/material.dart';

import 'add_maintenance_request.dart';

class ReplaceBrokenItem extends StatefulWidget {
  RoomDetailModel model;
  Room room;

  final VoidCallback somethingWasChanged;

  ReplaceBrokenItem({this.model, this.room, this.somethingWasChanged});

  @override
  _ReplaceBrokenItemState createState() => _ReplaceBrokenItemState();
}

class _ReplaceBrokenItemState extends State<ReplaceBrokenItem> {
  int selectedIndex = 0;
  bool somethingNewAdded = false;

  bool buttonEnabled = true;

  void deleteActionTapped(int i) async {
    bool didAccept = await showConfirmationDialog(context,
        message: 'That you want to delete this Replacement Request',
        title: 'Are you sure.',
        positiveBtnText: 'Yes',
        negativeBtnText: 'Cancel');

    if (didAccept) {
      setState(() {
        this.buttonEnabled = false;
      });

      this.widget.somethingWasChanged();

      var item = this.currentRecord[i];

      RoomApiProvider().deleteMaintainenceItem(
        item.id,
        successCallBack: () {
          setState(
            () {
              this.currentRecord.removeAt(i);

              this.somethingNewAdded = true;

              this.buttonEnabled = true;
            },
          );
        },
        failedCallBack: () {
          EasyLoading.showError('Error while removing record');
          setState(
            () {
              this.buttonEnabled = true;
            },
          );
        },
      );
    }

    //
  }

  List<Records> currentRecord;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //model

    currentRecord = this
        .widget
        .model
        .records
        .where((e) => e.typeC == 'Replacement')
        .toList();

    print(currentRecord);
  }

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
            if (this.buttonEnabled) ...[
              Wrap(
                spacing: 8.0, // gap between adjacent chips
                runSpacing: 4.0,
                children: [
                  for (int i = 0; i < currentRecord.length; i++) ...[
                    ButtonClose(
                      isSelected: selectedIndex == i,
                      name: currentRecord[i].name,
                      onTap: () {
                        setState(() {
                          selectedIndex = i;
                          _controller.text = '';
                        });
                      },
                      onDeleteTap: () {
                        deleteActionTapped(i);
                      },
                    ),
                  ],
                ],
              ),
            ] else ...[
              Container(
                height: 80,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
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
            if (1 == 2) ...[
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
                height: 20,
              ),
            ],
            PElevatedButton(
              text: 'Add Damage Item',
              onPressed: () {
                if (!this.buttonEnabled) {
                  return;
                }
                FocusManager.instance.primaryFocus.unfocus();

                if (_nameController.text.length > 0) {
                  EasyLoading.show(
                    status: 'Adding Request',
                  );
                  RoomApiProvider().addNewRequest(
                    this.widget.room.id,
                    _nameController.text,
                    _controller.text,
                    '',
                    'Replacement',
                    successCallBack: (value) {
                      this.somethingNewAdded = true;

                      Records record = Records();
                      record.name = _nameController.text;
                      //record.des = _controller.text;
                      record.id = value;

                      setState(() {
                        currentRecord.add(record);
                        setState(() {
                          _controller.text = '';
                          _nameController.text = '';
                        });
                      });

                      this.widget.somethingWasChanged();

                      EasyLoading.dismiss();
                    },
                    failedCallBack: () {
                      EasyLoading.dismiss();
                      EasyLoading.showToast('Error while adding Request');
                    },
                  );
                }
              },
              color: Color.fromRGBO(67, 128, 177, 1),
            ),

            /*SizedBox(
              height: 28,
            ),
            PElevatedButton(
              text: 'Save',
              onPressed: () {
                Navigator.pop(context);
              },
//background: rgba(67, 128, 177, 1);
            ),
            */
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
