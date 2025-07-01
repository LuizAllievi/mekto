import 'package:flutter/material.dart';
import 'package:mekto/main.dart';
import 'package:mekto/screen/product_favorite_screen/provider/favorite_provider.dart';
import 'package:mekto/screen/product_list_screen/provider/product_list_provider.dart';
import 'package:mekto/utility/extensions.dart';
import 'package:provider/provider.dart';

import '../core/data/data_provider.dart';
import '../models/product.dart';
import '../screen/product_details_screen/product_detail_screen.dart';
import '../screen/product_list_screen/components/category_selector.dart';
import '../screen/product_list_screen/components/poster_section.dart';
import '../utility/animation/open_container_wrapper.dart';
import 'product_grid_tile.dart';

class ProductGridView extends StatefulWidget {
  final loadHome;
  final loadFav;

  const ProductGridView(
      {super.key, required this.loadHome, this.loadFav = false});

  @override
  State<ProductGridView> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  late ProductListProvider productListProvider;
  late FavoriteProvider favoriteProvider;

  final loading = ValueNotifier(true);
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
    productListProvider = context.productListProvider;
    favoriteProvider = context.favoriteProvider;
    context.dataProvider.getAllPosters();
    context.productListProvider.emptyProducts();
    loadUsuarios();
  }

  infiniteScrolling() {
    var loadingBeforePixels = 0;

    if (_scrollController.position.pixels + loadingBeforePixels >=
            _scrollController.position.maxScrollExtent &&
        !loading.value) {
      loadUsuarios();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  loadUsuarios() async {
    loading.value = true;

    print("load inicial");
    if (!productListProvider.isQuering()) {
      widget.loadFav
          ? await productListProvider.getFavoriteProducts(favoriteProvider
              .loadFavoriteItems()
              .map((elem) => elem.toString())
              .toList())
          : await productListProvider.getProducts();
    } else {
      await productListProvider
          .getProductsByQuery(productListProvider.getQueryText());
    }

    loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.loadHome)
                        Text(
                          "Olá, " +
                              (context.userProvider.getLoginUsr()?.name ?? ''),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.white),
                          //               ),
                        ),
                      if (widget.loadHome)
                        Text(
                          "Qual peça você precisa hoje?",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      if (widget.loadHome) const PosterSection(),
                      if (widget.loadHome) const SizedBox(height: 5),
                      Text(
                        "Top Produtos",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      AnimatedBuilder(
                          animation: productListProvider,
                          builder: (context, snapshot) {
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: GridView.builder(
                                    itemCount:
                                        productListProvider.products.length,
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 10 / 18,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                    ),
                                    itemBuilder: (context, index) {
                                      Product product =
                                          productListProvider.products[index];
                                      return OpenContainerWrapper(
                                        nextScreen:
                                            ProductDetailScreen(product),
                                        child: ProductGridTile(
                                          product: product,
                                          index: index,
                                          isPriceOff: product.offerPrice != 0,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                loadingIndicatorWidget(),
                              ],
                            );
                          })
                    ]))));
  }

  loadingIndicatorWidget() {
    return ValueListenableBuilder(
        valueListenable: loading,
        builder: (context, bool isLoading, _) {
          return (isLoading)
              ? Positioned(
                  left: (MediaQuery.of(context).size.width / 2) - 20,
                  bottom: 24,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: CircleAvatar(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ))
              : Container();
        });
  }
}
