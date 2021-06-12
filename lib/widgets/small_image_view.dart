import 'package:flutter/material.dart';
import 'dart:io';

import 'ink_well.dart';

class SmallImageView extends StatelessWidget {
  final int index;
  final File file;
  final Function(int) onDelete;

  const SmallImageView({Key key, this.index, this.file, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.file(
            file,
            width: 100,
            height: 100,
            fit: BoxFit.fitWidth,
          ),
        ),
        Container(
          width: 120,
          height: 120,
          child: Align(
            alignment: Alignment.topRight,
            child: PInkWell(
              onTap: () {
                this.onDelete(index);
              },
              child: (Icon(
                Icons.remove_circle,
                color: Colors.red,
              )),
            ),
          ),
        ),
      ],
    );
  }
}
