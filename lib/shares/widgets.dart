import 'package:flutter/material.dart';
import 'package:winetopia_app/shares/setting.dart';

class Widgets {
  Widget titleInHome(String titleText) {
    return Text(
      titleText,
      style: TextStyle(
        fontSize: 22,
        color: Setting().textColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      title: Image.asset(
        'assets/images/Winetopia_Logo2024.png',
        height: 75,
        width: 75,
      ),
      backgroundColor: Setting().appBarBackgoundColor,
      scrolledUnderElevation: 0,
    );
  }
}
