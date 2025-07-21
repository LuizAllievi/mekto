import 'package:mekto/main.dart';
import 'package:mekto/utility/extensions.dart';

import '../../core/data/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utility/app_color.dart';
import '../lazy_test_screen/usuarios_list.dart';
import 'components/custom_app_bar.dart';
import '../../../../widget/product_grid_view.dart';
import 'components/category_selector.dart';
import 'components/poster_section.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: const CustomAppBar(),
        backgroundColor: AppColor.halloween,
        body: const Padding(
            padding: const EdgeInsets.all(20),
            child: const ProductGridView(loadHome: true)));
  }
}
