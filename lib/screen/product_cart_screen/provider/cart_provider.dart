import 'dart:developer';
import 'dart:io';
import 'package:mekto/screen/my_order_screen/my_order_screen.dart';
import 'package:mekto/utility/utility_extention.dart';

import '../../../models/coupon.dart';
import '../../login_screen/provider/user_provider.dart';
import '../../../services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/api_response.dart';
import '../../../utility/constants.dart';
import '../../../utility/snack_bar_helper.dart';

class CartProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final box = GetStorage();

  final UserProvider _userProvider;
  var flutterCart = FlutterCart();
  List<CartModel> myCartItems = [];

  final GlobalKey<FormState> buyNowFormKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController couponController = TextEditingController();
  bool isExpanded = false;

  Coupon? couponApplied;
  double couponCodeDiscount = 0;
  String selectedPaymentOption = 'pago';

  CartProvider(this._userProvider);

  void updateCart(CartModel cartItem, int quantity) {
    quantity = cartItem.quantity + quantity;
    flutterCart.updateQuantity(cartItem.productId, cartItem.variants, quantity);
    notifyListeners();
  }

  double getCartSubTotal() {
    return flutterCart.subtotal;
  }

  double getGrandTotal() {
    return getCartSubTotal() - couponCodeDiscount;
  }

  getCartItems() {
    myCartItems = flutterCart.cartItemsList;
    notifyListeners();
  }

  clearCartItems() {
    flutterCart.clearCart();
    notifyListeners();
  }

  checkCoupon() async {
    try {
      if (couponController.text.isEmpty) {
        SnackBarHelper.showErrorSnackBar("Digite o Cupom de Desconto!");
        return;
      }

      List<String> productIds =
          myCartItems.map((carItem) => carItem.productId).toList();
      Map<String, dynamic> couponData = {
        "couponCode": couponController.text,
        "purchaseAmount": getCartSubTotal(),
        "productIds": productIds
      };

      final response = await service.addItem(
          endpointUrl: "api/coupons/checkCoupon", itemData: couponData);
      if (response.isOk) {
        Coupon? coupon = Coupon.fromJson(response.body as Map<String, dynamic>);
        if (coupon != null) {
          couponApplied = coupon;
          couponCodeDiscount = getCouponDiscountAmount(coupon);
          updateUI();
        }
        SnackBarHelper.showSuccessSnackBar("Cupom aplicado com sucesso!");
      } else {
        SnackBarHelper.showErrorSnackBar(
            "Erro ao aplicar cupom! " + response.body);
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar("Erro ao aplicar cupom!");
    }
  }

  double getCouponDiscountAmount(Coupon coupon) {
    double discountAmount = 0;
    String discountType = coupon.discountType ?? "fixo";
    if (discountType == "fixo") {
      discountAmount = coupon.discountAmount ?? 0;
      return discountAmount;
    } else {
      double discountPercentage = coupon.discountAmount ?? 0;
      double amountAfterDiscountPercentage =
          getCartSubTotal() * (discountPercentage / 100);
      return amountAfterDiscountPercentage;
    }
  }

  addOrder(BuildContext context) async {
    try {
      Map<String, dynamic> order = {
        "orderStatus": "pendente",
        "items": cartItemToOrderItem(myCartItems),
        "shippingAddress": {
          "phone": phoneController.text,
          "street": streetController.text,
          "state": stateController.text,
          "city": cityController.text,
          "cep": postalCodeController.text,
          "country": countryController.text
        },
        "paymentMethod": selectedPaymentOption,
        "couponId:": couponApplied?.sId.toString() ?? '',
        "subtotal": getCartSubTotal(),
        "discount": couponCodeDiscount,
        "totalPrice": getGrandTotal()
      };
      final response =
          await service.addItem(endpointUrl: "api/orders", itemData: order);
      if (response.isOk) {
        clearCartItems();
        clearCouponDiscount();
        SnackBarHelper.showSuccessSnackBar("Pedido criado com sucesso!");
        Navigator.pop(context);
      } else {
        SnackBarHelper.showErrorSnackBar("Erro ao criar pedido");
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar("Erro ao criar pedido");
      rethrow;
    }
  }

  List<Map<String, dynamic>> cartItemToOrderItem(List<CartModel> cartItems) {
    return cartItems.map((cartItem) {
      print(cartItem.variants.safeElementAt(0)?.color ?? "");
      return {
        'productId': cartItem.productId,
        'productName': cartItem.productName,
        'quantity': cartItem.quantity,
        'price': cartItem.variants.safeElementAt(0)?.price ?? 0,
        'variantName': cartItem.variants.safeElementAt(0)?.color ?? "",
      };
    }).toList();
  }

  submitOrder(BuildContext context) async {
    if (selectedPaymentOption == "pagar_na_entrega") {
      addOrder(context);
    }
  }

  clearCouponDiscount() {
    couponApplied = null;
    couponCodeDiscount = 0;
    couponController.text = '';
    notifyListeners();
  }

  void retrieveSavedAddress() {
    phoneController.text = box.read(PHONE_KEY) ?? '';
    streetController.text = box.read(STREET_KEY) ?? '';
    cityController.text = box.read(CITY_KEY) ?? '';
    stateController.text = box.read(STATE_KEY) ?? '';
    postalCodeController.text = box.read(POSTAL_CODE_KEY) ?? '';
    countryController.text = box.read(COUNTRY_KEY) ?? '';
  }

  void updateUI() {
    notifyListeners();
  }
}
