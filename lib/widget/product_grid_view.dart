import 'package:flutter/material.dart';
import 'package:mekto/screen/product_favorite_screen/provider/favorite_provider.dart';
import 'package:mekto/screen/product_list_screen/provider/product_list_provider.dart';
import 'package:mekto/utility/app_color.dart';
import 'package:mekto/utility/extensions.dart';
import 'package:mekto/widget/no_product_found_banner.dart';
import '../models/product.dart';
import '../screen/product_details_screen/product_detail_screen.dart';
import '../utility/animation/open_container_wrapper.dart';
import 'product_grid_tile.dart';

class ProductGridView extends StatefulWidget {
  final bool loadHome;
  final bool loadFav;

  const ProductGridView({
    super.key,
    required this.loadHome,
    this.loadFav = false,
  });

  @override
  State<ProductGridView> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  late ProductListProvider productListProvider;
  late FavoriteProvider favoriteProvider;

  final loading = ValueNotifier(true);
  late final ScrollController _scrollController;

  int _scrollToEndCount = 0; // ✅ ADICIONADO
  bool _showHelpBanner = false; // ✅ ADICIONADO

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
    productListProvider = context.productListProvider;
    favoriteProvider = context.favoriteProvider;
    context.dataProvider.getAllPosters();
    context.productListProvider.emptyProducts();
    productListProvider.setQuering(false);
    loadUsuarios();
  }

  infiniteScrolling() async {
    var loadingBeforePixels = 0;

    if (_scrollController.position.pixels + loadingBeforePixels >=
            _scrollController.position.maxScrollExtent &&
        !loading.value) {
      _scrollToEndCount++; // ✅ ADICIONADO

      if (_scrollToEndCount >= 6 && !_showHelpBanner) {
        setState(() {
          _showHelpBanner = true;
          _scrollToEndCount = 0;
        });
      }

      await loadUsuarios();

      // Verifica se chegou no fim da lista para mostrar banner
      if (productListProvider.getEndOfResults() && !_showHelpBanner) {
        setState(() {
          _showHelpBanner = true;
          _scrollToEndCount = 0;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  loadUsuarios() async {
    loading.value = true;

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
      child: Stack(
        children: [
          SingleChildScrollView(
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
                          color: AppColor.pretoAssombroso),
                    ),
                  if (widget.loadHome)
                    const Text(
                      "Qual peça você precisa hoje?",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: AppColor.branco),
                    ),
                  AnimatedBuilder(
                    animation: productListProvider,
                    builder: (context, snapshot) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          children: [
                            GridView.builder(
                              itemCount: productListProvider.products.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
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
                                  nextScreen: ProductDetailScreen(product),
                                  child: ProductGridTile(
                                    product: product,
                                    index: index,
                                    isPriceOff: product.offerPrice != 0,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                                height: 100), // espaço para não tapar conteúdo
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          loadingIndicatorWidget(),
          if (_showHelpBanner)
            Positioned.fill(
              child: Center(
                child: Material(
                  elevation: 12,
                  borderRadius: BorderRadius.circular(12),
                  child: NoProductFoundBanner(
                    onClose: () {
                      setState(() {
                        _showHelpBanner = false;
                      });
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  loadingIndicatorWidget() {
    return ValueListenableBuilder(
      valueListenable: loading,
      builder: (context, bool isLoading, _) {
        return (isLoading)
            ? Positioned(
                left: (MediaQuery.of(context).size.width / 2) - 20,
                bottom: 24,
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircleAvatar(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
              )
            : Container();
      },
    );
  }
}
