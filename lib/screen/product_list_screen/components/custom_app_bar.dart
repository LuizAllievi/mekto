import 'package:flutter/material.dart';
import 'package:mekto/utility/app_color.dart';
import 'package:mekto/utility/extensions.dart';
import 'package:mekto/widget/no_product_found_banner.dart';

import '../../../widget/custom_search_bar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    context.productListProvider.emptyProducts();
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: CustomSearchBar(
                    controller: TextEditingController(),
                    onChanged: (val) {
                      context.productListProvider.emptyProducts();
                      if (val == '') {
                        context.productListProvider.setQuering(false);
                        context.productListProvider.getProducts();
                      } else {
                        context.productListProvider.setQuering(true);
                        context.productListProvider.getProductsByQuery(val);
                      }
                    },
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.help),
                color: AppColor.halloween,
                style: ButtonStyle(iconSize: MaterialStateProperty.all(27.0)),
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (_) {
                      return Stack(
                        children: [
                          Positioned.fill(
                            child: Center(
                              child: Material(
                                elevation: 12,
                                borderRadius: BorderRadius.circular(12),
                                child: NoProductFoundBanner(
                                  onClose: () {
                                    Navigator.of(context)
                                        .pop(); // Fecha o banner
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          )),
    );
  }
}
