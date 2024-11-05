import 'package:flutter/material.dart';

class Styles {
  static final Styles _instance = Styles._internal();

  factory Styles() => _instance;

  Styles._internal();

  static const lightPurple1 = Color(0xffFAF0FF);
  static const lightPurple2 = Color(0xff31A4F7);
  static const mainPurple = Color(0xff8501BC);
  static const darkPurple1 = Color(0xff3D0056);
  static const darkPurple2 = Color(0xff190024);
  static const lightGrey0 = Color(0xffE8E8E8);
  static const lightGrey1 = Color(0xffDCDCDC);
  static const lightGrey2 = Color(0xffD0D0D0);
  static const mainGrey = Color(0xff8A8A8A);
  static const darkGrey1 = Color(0xff717171);
  static const darkGrey2 = Color(0xff3E3E3E);
  static const mainRed = Color(0xffF24D4B);
  static const mainYellow = Color(0xffFFC529);
  static const mainGreen = Color(0xff67CE94);
  static const mainBlue = Color(0xff31A4F7);
  static const darkBlue = Color(0xff0071C4);
  static const textColor = Color(0xff190024);
  static const surfaceColor = Color(0xffFCFCFE);

  static const titleLarge = TextStyle(
    color: Styles.textColor,
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );

  static const titleMedium = TextStyle(
    color: Styles.textColor,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  static const titleSmall = TextStyle(
    color: Styles.textColor,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const bodyLarge = TextStyle(
    color: Styles.textColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const bodyMedium = TextStyle(
    color: Styles.textColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const bodySmall = TextStyle(
    color: Styles.textColor,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}
