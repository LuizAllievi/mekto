import 'package:mekto/utility/app_color.dart';
import 'package:mekto/widget/custom_image_network.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/product.dart';
import '../screen/product_favorite_screen/provider/favorite_provider.dart';
import '../utility/extensions.dart';
import '../utility/utility_extention.dart';

class ProductGridTile extends StatelessWidget {
  final Product product;
  final int index;
  final bool isPriceOff;

  const ProductGridTile({
    super.key,
    required this.product,
    required this.index,
    required this.isPriceOff,
  });

  @override
  Widget build(BuildContext context) {
    double discountPercentage = context.dataProvider
        .calculateDiscountPercentage(
            product.price ?? 0, product.offerPrice ?? 0);
    return GridTile(
      header: Padding(
        padding: const EdgeInsets.only(top: 1, right: 10, left: 10, bottom: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: discountPercentage != 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                width: 80,
                height: 20,
                alignment: Alignment.center,
                child: Text(
                  "${discountPercentage.toInt()}% OFF",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Consumer<FavoriteProvider>(
              builder: (context, favoriteProvider, child) {
                return IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color:
                        favoriteProvider.checkIsItemFavorite(product.sId ?? '')
                            ? AppColor.pretoAssombroso
                            : AppColor.platinado,
                  ),
                  onPressed: () {
                    context.favoriteProvider
                        .updateToFavoriteList(product.sId ?? '');
                  },
                );
              },
            ),
          ],
        ),
      ),
      footer: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(7),
          height: 110,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nome da empresa com overflow ellipsis e uma fonte menor
              FittedBox(
                child: Text(
                  product.companyName ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300, // Deixar mais leve
                    color: Colors.grey,
                    fontSize: 9, // Reduzido para caber bem
                  ),
                ),
              ),
              const SizedBox(
                  height:
                      4), // Um espacinho entre o nome da empresa e o produto
              Text(
                product.name ?? '',
                overflow:
                    TextOverflow.ellipsis, // Faz o texto não sair do espaço
                maxLines: 2, // Limitar a 2 linhas
                style: const TextStyle(
                  fontWeight: FontWeight.w400, // Peso de fonte mais equilibrado
                  color: Colors.black,
                  fontSize: 12, // Um pouco maior para o nome do produto
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  if (product.offerPrice != null &&
                      product.offerPrice != product.price)
                    Flexible(
                      child: Text(
                        // Formata o preço original (riscado)
                        NumberFormat.simpleCurrency(locale: 'pt_BR')
                            .format(product.price),
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 8,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      // Formata o preço com o desconto, caso exista
                      product.offerPrice != 0
                          ? NumberFormat.simpleCurrency(locale: 'pt_BR')
                              .format(product.offerPrice)
                          : NumberFormat.simpleCurrency(locale: 'pt_BR')
                              .format(product.price),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 80),
        decoration: BoxDecoration(
          color: AppColor.platinado,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(8),
            child: CustomImageNetwork(
              path: product.images?.safeElementAt(0)?.path ?? '',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
