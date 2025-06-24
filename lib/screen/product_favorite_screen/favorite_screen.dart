import 'package:mekto/main.dart';
import 'package:mekto/screen/lazy_test_screen/usuarios_list.dart';
import 'package:mekto/utility/extensions.dart';

import 'provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widget/product_grid_view.dart';
import '../../utility/app_color.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.productListProvider.emptyProducts();
    context.productListProvider.setQuering(false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favoritos",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColor.darkOrange),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: const ProductGridView(loadHome: false, loadFav: true)
          // child: Consumer<FavoriteProvider>(
          //   builder: (context, favoriteProvider, child) {
          //     return ProductGridView(
          //       items: favoriteProvider.favoriteProduct,
          //     );
          //   },
          // )
          ),
    );
  }
}
