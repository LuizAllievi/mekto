import 'package:intl/intl.dart';
import 'package:mekto/main.dart';
import 'package:mekto/utility/app_color.dart';
import 'package:mekto/utility/extensions.dart';

import 'provider/product_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widget/carousel_slider.dart';
import '../../../../widget/page_wrapper.dart';
import '../../models/product.dart';
import '../../widget/horizondal_list.dart';
import 'components/product_rating_section.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: PageWrapper(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //? product image section
                Container(
                  height: height * 0.36,
                  width: width,
                  decoration: const BoxDecoration(
                    color: AppColor.platinado,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                    ),
                  ),
                  child: CarouselSlider(items: product.images ?? []),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //? product nam e
                      Text(
                        '${product.name}',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 10),
                      //? product rating section
                      // const ProductRatingSection(),
                      const SizedBox(height: 10),
                      //? product rate , offer , stock section
                      Row(
                        children: [
                          Text(
                            product.offerPrice != null
                                ? NumberFormat.simpleCurrency(locale: 'pt_BR')
                                    .format(product.offerPrice)
                                : NumberFormat.simpleCurrency(locale: 'pt_BR')
                                    .format(product.price),
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          const SizedBox(width: 3),
                          Visibility(
                            visible: product.offerPrice != product.price,
                            child: Text(
                              NumberFormat.simpleCurrency(locale: 'pt_BR')
                                  .format(product.price),
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            product.quantity != 0
                                ? "Estoque: ${product.quantity}"
                                : "Sem estoque",
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      product.proVariantId!.isNotEmpty
                          ? Text(
                              '${product.proVariantTypeId?.type}',
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 14),
                            )
                          : const SizedBox(),
                      Consumer<ProductDetailProvider>(
                        builder: (context, proDetailProvider, child) {
                          return HorizontalList(
                            items: product.proVariantId
                                ?.map((item) => item.name)
                                .toList(),
                            itemToString: (val) => val ?? '',
                            selected: proDetailProvider.selectedVariant,
                            onSelect: (val) {
                              proDetailProvider.selectedVariant = val;
                              proDetailProvider.updateUI();
                            },
                          );
                        },
                      ),
                      //? product description
                      Text(
                        "Descrição",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 10),
                      Text("${product.description}"),
                      const SizedBox(height: 40),
                      //? add to cart button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return AppColor.lightBlue;
                                }
                                return AppColor.darkOrange;
                                // Use the component's default.
                              },
                            ),
                          ),
                          onPressed: product.quantity != 0
                              ? () {
                                  context.proDetailProvider.addToCart(product);
                                }
                              : null,
                          child: const Text("Adicionar ao Carrinho",
                              style: TextStyle(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
