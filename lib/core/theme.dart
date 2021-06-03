import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'colors.dart';

ThemeData getAppTheme(BuildContext context) {
  final inputBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
    ),
  );
  return ThemeData(
    cardColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),

    scaffoldBackgroundColor: Color.fromRGBO(253, 253, 253, 1),
    primaryColor: PColors.black,
    accentColor: PColors.blue,
    primarySwatch: Colors.blue,
    primaryColorBrightness: Brightness.dark,
    accentColorBrightness: Brightness.dark,
    fontFamily: 'Roboto',
    appBarTheme: AppBarTheme(
      centerTitle: true,
      brightness: Brightness.dark,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      textTheme: Theme.of(context).textTheme,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      hintStyle: TextStyle(
        color: PColors.blue,
      ),
      border: inputBorder,
      focusedBorder: inputBorder,
      enabledBorder: inputBorder,
      focusColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        elevation: MaterialStateProperty.all(0),
        minimumSize: MaterialStateProperty.all(Size.fromHeight(50)),
        backgroundColor: MaterialStateProperty.all(PColors.blue),
        textStyle: MaterialStateProperty.all(
          TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    ),
    cupertinoOverrideTheme: CupertinoThemeData(primaryColor: PColors.blue),
    dividerTheme: DividerThemeData(
      thickness: 1.3,
      color: PColors.black,
    ),

    //CupertinoSegmentedControl
  );
}

ThemeData getAppThemeDark(BuildContext context) {
  final inputBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
    ),
  );
  return ThemeData(
    cardColor: Color.fromRGBO(50, 50, 50, 1),
    iconTheme: IconThemeData(color: Colors.black),
    scaffoldBackgroundColor: Color.fromRGBO(30, 30, 30, 1),
    primaryColor: PColors.black,
    accentColor: PColors.blue,
    primarySwatch: Colors.blueGrey,
    primaryColorBrightness: Brightness.dark,
    accentColorBrightness: Brightness.dark,
    fontFamily: 'Roboto',
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.white),
      centerTitle: true,
      brightness: Brightness.dark,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      textTheme: Theme.of(context).textTheme,
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: PColors.text_field_background_dark,
      filled: true,
      hintStyle: TextStyle(
        color: PColors.text_colorDart,
      ),
      border: inputBorder,
      focusedBorder: inputBorder,
      enabledBorder: inputBorder,
      focusColor: Colors.black12,
      labelStyle: TextStyle(
        color: PColors.grayColorForDark,
      ),
    ),

    /*
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      hintStyle: TextStyle(
        color: PColors.blue,
      ),
      border: inputBorder,
      focusedBorder: inputBorder,
      enabledBorder: inputBorder,
      focusColor: Colors.white,
    ),
    */


    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        elevation: MaterialStateProperty.all(0),
        minimumSize: MaterialStateProperty.all(Size.fromHeight(50)),
        backgroundColor: MaterialStateProperty.all(PColors.blue),
        textStyle: MaterialStateProperty.all(
          TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    ),
    cupertinoOverrideTheme: CupertinoThemeData(primaryColor: PColors.blue),
    dividerTheme: DividerThemeData(
      thickness: 1.3,
      color: PColors.black,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline2: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: PColors.text_colorDart,
      ),
      caption: TextStyle(
        color: PColors.text_colorDart,
        fontSize: 14,
      ),
      subtitle2: TextStyle(
        color: PColors.text_error_color,
        fontSize: 14,
      ),
      bodyText2: TextStyle(
        color: PColors.text_colorDart,
        fontSize: 14,
      ),
      headline3: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: PColors.text_colorDart,
      ),
      headline4: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: PColors.text_colorDart,
      ),
      headline5: TextStyle(
        fontSize: 16,
        color: PColors.text_colorDart,
      ),
      headline6: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: PColors.text_colorDart,
      ),
    ),

    //CupertinoSegmentedControl
  );
}
