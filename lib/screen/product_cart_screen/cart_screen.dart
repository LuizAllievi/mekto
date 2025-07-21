import 'package:intl/intl.dart';

import 'provider/cart_provider.dart';
import '../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utility/animation/animated_switcher_wrapper.dart';
import '../../utility/app_color.dart';
import 'components/buy_now_bottom_sheet.dart';
import 'components/cart_list_section.dart';
import 'components/empty_cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      context.cartProvider.getCartItems();
    });
    return Scaffold(
      backgroundColor: AppColor.halloween,
      appBar: AppBar(
        title: const Text(
          "Meu Carrinho",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColor.branco),
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          print(cartProvider.myCartItems);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              cartProvider.myCartItems.isEmpty
                  ? const EmptyCart()
                  : Consumer<CartProvider>(
                      builder: (context, cartProvider, child) {
                        return CartListSection(
                            cartProducts: cartProvider.myCartItems);
                      },
                    ),

              Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: AppColor.branco),
                    ),
                    AnimatedSwitcherWrapper(
                      child: Text(
                        NumberFormat.simpleCurrency(locale: 'pt_BR')
                            .format(context.cartProvider.getCartSubTotal()),
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: AppColor.branco,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //? buy now button
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                        backgroundColor: AppColor.branco),
                    onPressed: context.cartProvider.myCartItems.isEmpty
                        ? null
                        : () {
                            showCustomBottomSheet(context);
                          },
                    child: const Text("Comprar Agora",
                        style: TextStyle(color: AppColor.halloween)),
                  ),
                ),
              )

              //? total price section

              //? buy now button
            ],
          );
        },
      ),
    );
  }
}
