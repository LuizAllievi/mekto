import 'package:flutter/material.dart';
import '../../utility/app_color.dart';
import 'components/custom_app_bar.dart';
import '../../../../widget/product_grid_view.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: CustomAppBar(),
        backgroundColor: AppColor.halloween,
        body: Padding(
            padding: EdgeInsets.all(20),
            child: ProductGridView(loadHome: true)));
  }
}
