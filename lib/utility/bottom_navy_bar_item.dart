import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart' show Color, Colors, Icon;
import 'package:mekto/utility/app_color.dart';

@immutable
class BottomNavyBarItem {
  final String title;
  final Icon icon;
  final Color activeColor;
  final Color inActiveColor;

  const BottomNavyBarItem(this.title, this.icon, this.activeColor,
      [this.inActiveColor = AppColor.lightBlue]);
}
