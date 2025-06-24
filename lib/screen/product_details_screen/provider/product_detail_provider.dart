import 'package:mekto/models/product.dart';
import 'package:mekto/screen/my_order_screen/my_order_screen.dart';
import 'package:mekto/utility/snack_bar_helper.dart';
import 'package:mekto/utility/utility_extention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cart/flutter_cart.dart';
import '../../../core/data/data_provider.dart';

class ProductDetailProvider extends ChangeNotifier {
  final DataProvider _dataProvider;
  String? selectedVariant;
  var flutterCart = FlutterCart();

  ProductDetailProvider(this._dataProvider);

  void addToCart(Product product) {
    if (product.proVariantId!.isNotEmpty && selectedVariant == null) {
      SnackBarHelper.showErrorSnackBar("Por favor, selecione uma variação!");
      return;
    }

    double? price = product.offerPrice != product.price
        ? product.offerPrice
        : product.price;
    if (flutterCart.cartItemsList
            .where((cartModel) =>
                cartModel.productMeta?["companyName"] != product.companyName)
            .toList()
            .length >
        0) {
      SnackBarHelper.showErrorSnackBar("Finalize a compra na loja " +
          (flutterCart.cartItemsList[0].productMeta!["companyName"]) +
          " primeiro!");
      return null;
    }
    flutterCart.addToCart(
        cartModel: CartModel(
            productId: '${product.sId}',
            productName: '${product.name}',
            productMeta: {"companyName": product.companyName},
            productImages: ['${product.images.safeElementAt(0)?.path}'],
            variants: [
              ProductVariant(price: price ?? 0, color: selectedVariant)
            ],
            productDetails: '${product.description}'));

    selectedVariant = null;
    SnackBarHelper.showSuccessSnackBar("Item Adicionado ao Carrinho!");
    notifyListeners();
  }

  void updateUI() {
    notifyListeners();
  }
}
