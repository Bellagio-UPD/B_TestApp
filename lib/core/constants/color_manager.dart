import 'package:flutter/material.dart';

class AppColors {
  static const Gradient backgroundColor = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColors.purple1,
        AppColors.purple2,
        AppColors.purple1,
      ]);
  static const Gradient accentColor = LinearGradient(
      colors: [AppColors.gold1, AppColors.gold2, AppColors.gold1]);
  static const purple1 = Color(0xff180027);
  static const purple2 = Color(0xff48002B);
  static const purple3 = Color(0xff310129);
  static const gold1 = Color(0xffB58416);
  static const gold2 = Color(0xffEDD295);
  static const secondaryColor = Color(0xffFFFADD);
  static const textfieldColor = Color.fromRGBO(255, 250, 221, 0.7);
  static const dateTimeColor = Color.fromRGBO(255, 250, 221, 0.5);
  static const airTicketContentColor = Color.fromRGBO(0, 0, 0, 0.5);
  static const textColor = Color(0xff000000);
  static const contentTextColor = Color.fromRGBO(0, 0, 0, 0.7);
  static const tileColor = Color.fromRGBO(255, 250, 221, 0.1);
  static const navbarColor = Color(0xff10001B);
  static const navbarActive = Color(0xffECD194);
  static const navbarInactive = Color(0xff5C5362);
  static const boardingPassTile = Color(0xffEEE9CE);
}
