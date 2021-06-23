import 'package:bn_staff/core/colors.dart';
import 'package:flutter/material.dart';

Future<bool> showConfirmationDialog(
  BuildContext context, {
  String title,
  String message,
  String positiveBtnText,
  String negativeBtnText,
  bool showPositiveBtn = true,
  bool showNegativeBtn = true,
}) async {
  bool isYes = await showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: title != null ? Text(title) : null,
      content: Text(
        'General_Are_You_Sure',
      ),
      actions: [
        if (showNegativeBtn)
          TextButton(
            child: Text(
              'General_No',
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
        if (showPositiveBtn)
          TextButton(
            child: Text(
              positiveBtnText ?? 'General_Yes',
            ),
            onPressed: () => Navigator.pop(context, true),
          ),
      ],
    ),
  );
  return isYes == true;
}

Future<bool> showInfoDialog(
  BuildContext context, {
  String title,
  @required String message,
}) {
  return showConfirmationDialog(context,
      title: title,
      message: message,
      showNegativeBtn: false,
      positiveBtnText: 'OK');
}

Future<void> showProgressDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 32),
              Text(
                'General_Please_Wait',
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Future<dynamic> showBottomSheit(BuildContext context, Widget widget)async {

  var check = await showModalBottomSheet(
    barrierColor: MediaQuery.of(context).platformBrightness == Brightness.dark
        ? Colors.grey.withOpacity(0.5)
        : Colors.black.withOpacity(0.5),
    context: context,
    isScrollControlled: true,
    builder: (context) => SingleChildScrollView(
      child: Container(
        color: Colors.transparent,
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: widget,
      ),
    ),
  );

  if (check != null) {
    print(check);

    return check;
  }


  return null;



}
