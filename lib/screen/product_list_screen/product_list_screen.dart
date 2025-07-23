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
        backgroundColor: AppColor.platinado2,
        body: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: ProductGridView(loadHome: true)));
  }
}
