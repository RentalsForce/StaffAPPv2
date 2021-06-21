import 'package:bn_staff/pages/home.dart';
import 'package:bn_staff/pages/initial_loader.dart';
import 'package:bn_staff/pages_v2/tasks_home.dart';
import 'package:bn_staff/util/custom_amination.dart';
import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  configLoading();

  runApp(MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.dualRing
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking Ninja',
      theme: getAppTheme(context),
      darkTheme: getAppThemeDark(context),
      builder: EasyLoading.init(),
      home: InitialLoader(),
   // home: Home(),
    );
  }
}

