import 'package:intl/intl.dart';
import 'package:mekto/main.dart';
import 'package:mekto/utility/app_color.dart';
import 'package:mekto/utility/extensions.dart';
import 'package:mekto/widget/custom_image_network.dart';

import '../../../utility/utility_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';

class CartListSection extends StatelessWidget {
  final List<CartModel> cartProducts;

  const CartListSection({
    super.key,
    required this.cartProducts,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: cartProducts.mapWithIndex((index, _) {
            CartModel cartItem = cartProducts[index];
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.all(8), // reduzido
              padding: const EdgeInsets.all(10), // reduzido
              decoration: BoxDecoration(
                color: AppColor.areia,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Informações do produto
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartItem.productMeta?["companyName"] ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          cartItem.productName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          'Valor: ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(cartItem.variants.safeElementAt(0)?.price)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8), // reduzido
                  // Imagem e controle de quantidade
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.all(4), // menor
                            child: CustomImageNetwork(
                              path:
                                  cartItem.productImages.safeElementAt(0) ?? '',
                              height: 80,
                              width: 80,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6), // reduzido
                      Container(
                        height: 30, // altura total reduzida
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 14, // menor ainda
                              splashRadius: 12,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 24,
                                minHeight: 24,
                              ),
                              onPressed: () {
                                context.cartProvider.updateCart(cartItem, -1);
                              },
                              icon: const Icon(Icons.remove,
                                  color: Color(0xFFEC6813)),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '${cartItem.quantity}',
                              style: const TextStyle(
                                fontSize: 13, // menor
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 2),
                            IconButton(
                              iconSize: 14,
                              splashRadius: 12,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 24,
                                minHeight: 24,
                              ),
                              onPressed: () {
                                context.cartProvider.updateCart(cartItem, 1);
                              },
                              icon: const Icon(Icons.add,
                                  color: Color(0xFFEC6813)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
