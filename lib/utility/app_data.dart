import 'package:flutter/material.dart';
import 'package:mekto/utility/app_color.dart';

import 'bottom_navy_bar_item.dart';

class AppData {
  const AppData._();

  static List<Color> randomColors = [
    const Color(0xFFFCE4EC),
    const Color(0xFFF3E5F5),
    const Color(0xFFEDE7F6),
    const Color(0xFFE3F2FD),
    const Color(0xFFE0F2F1),
    const Color(0xFFF1F8E9),
    const Color(0xFFFFF8E1),
    const Color(0xFFECEFF1),
  ];

  static List<Color> randomPosterBgColors = [
    AppColor.verdeCha,
    AppColor.abobora,
    AppColor.areia,
    AppColor.caramelinho,
    AppColor.pretoAssombroso,
    AppColor.pretoAssombroso,
    AppColor.pretoAssombroso,
    AppColor.pretoAssombroso,
  ];

  static List<BottomNavyBarItem> bottomNavyBarItems = [
    const BottomNavyBarItem(
      "Início",
      Icon(Icons.home),
      AppColor.halloween,
    ),
    // const BottomNavyBarItem(
    //   "Favoritos",
    //   Icon(Icons.favorite),
    //   AppColor.darkOrange,
    // ),
    const BottomNavyBarItem(
      "Carrinho",
      Icon(Icons.shopping_cart),
      AppColor.darkOrange,
    ),
    const BottomNavyBarItem(
      "Minha Conta",
      Icon(Icons.person),
      AppColor.darkOrange,
    ),
  ];
}
