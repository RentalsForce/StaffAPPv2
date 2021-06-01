import 'package:bn_staff/core/colors.dart';
import 'package:bn_staff/widgets/p_button.dart';
import 'package:flutter/material.dart';

class NoTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'No task for now',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: PColors.gray,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            flex: 7,
            child: Text(
              'Please wait until you\nget a notification',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: PColors.gray,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ErrorTaskView extends StatelessWidget {

  final VoidCallback onTap;

  ErrorTaskView({this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Could not load data',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: PColors.gray,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            flex: 7,
            child: Column(
              children: [
                Text(
                  'Tap on the button below to retry.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: PColors.gray,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                PButton(
                  title: 'Retry',
                  action: () {
                    this.onTap.call();

                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
