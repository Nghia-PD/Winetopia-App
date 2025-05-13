import 'package:flutter/widgets.dart';
import 'package:winetopia_app/shares/setting.dart';

class Widgets {
  Widget titleInHome(String titleText) {
    return Text(
      titleText,
      style: TextStyle(
        fontSize: 26,
        color: Setting().textColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
