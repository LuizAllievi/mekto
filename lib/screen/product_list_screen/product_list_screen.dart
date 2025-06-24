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
        backgroundColor: AppColor.pessego,
        body: const Padding(
            padding: const EdgeInsets.all(20),
            child: const ProductGridView(loadHome: true)));
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     extendBodyBehindAppBar: true,
  //     appBar: const CustomAppBar(),
  //     body: SafeArea(
//   //       child: SingleChildScrollView(
//   //         child: Padding(
  //           padding: const EdgeInsets.all(20),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 "Olá, " +( context.userProvider.getLoginUsr()?.name ?? ''),
  //                 style: Theme.of(context).textTheme.displayLarge,
  //               ),
  //               Text(
  //                 "Qual peça você precisa hoje?",
  //                 style: Theme.of(context).textTheme.headlineSmall,
  //               ),
  //               const PosterSection(),
  //               Text(
  //                 "Top Categorias",
  //                 style: Theme.of(context).textTheme.headlineMedium,
  //               ),
  //               const SizedBox(height: 5),
  //               Consumer<DataProvider>(
  //                 builder: (context, dataProvider, child) {
  //                   return CategorySelector(
  //                     categories: dataProvider.categories,
  //                   );
  //                 },
  //               ),
  //               Consumer<DataProvider>(
  //                 builder: (context, dataProvider, child) {
  //
  //                   return ProductGridView(
  //
  //
  //                   );
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
