import 'dart:ui';
import '../provider/cart_provider.dart';
import '../../../utility/extensions.dart';
import '../../../widget/compleate_order_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widget/applay_coupon_btn.dart';
import '../../../widget/custom_dropdown.dart';
import '../../../widget/custom_text_field.dart';

void showCustomBottomSheet(BuildContext context) {
  context.cartProvider.clearCouponDiscount();
  context.cartProvider.retrieveSavedAddress();
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: context.cartProvider.buyNowFormKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Toggle Address Fields
                ListTile(
                  title: const Text('Digite o Endereço'),
                  trailing: IconButton(
                    icon: Icon(context.cartProvider.isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                    onPressed: () {
                      context.cartProvider.isExpanded = !context.cartProvider.isExpanded;
                      (context as Element).markNeedsBuild();
                    },
                  ),
                ),

                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    return Visibility(
                      visible: cartProvider.isExpanded,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            CustomTextField(
                              height: 65,
                              labelText: 'Celular',
                              onSave: (value) {},
                              inputType: TextInputType.number,
                              controller: context.cartProvider.phoneController,
                              validator: (value) => value!.isEmpty ? 'Por favor, digite o número de celular' : null,
                            ),
                            CustomTextField(
                              height: 65,
                              labelText: 'Rua',
                              onSave: (val) {},
                              controller: context.cartProvider.streetController,
                              validator: (value) => value!.isEmpty ? 'Digite a rua' : null,
                            ),
                            CustomTextField(
                              height: 65,
                              labelText: 'Cidade',
                              onSave: (value) {},
                              controller: context.cartProvider.cityController,
                              validator: (value) => value!.isEmpty ? 'Digite a cidade' : null,
                            ),
                            CustomTextField(
                              height: 65,
                              labelText: 'Estado',
                              onSave: (value) {},
                              controller: context.cartProvider.stateController,
                              validator: (value) => value!.isEmpty ? 'Por favor, digite o estado' : null,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    height: 65,
                                    labelText: 'CEP',
                                    onSave: (value) {},
                                    inputType: TextInputType.number,
                                    controller: context.cartProvider.postalCodeController,
                                    validator: (value) => value!.isEmpty ? 'Por favor, digite o CEP' : null,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomTextField(
                                    height: 65,
                                    labelText: 'País',
                                    onSave: (value) {},
                                    controller: context.cartProvider.countryController,
                                    validator: (value) => value!.isEmpty ? 'Por favor, digite o país' : null,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Payment Options
                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    return CustomDropdown<String>(
                        bgColor: Colors.white,
                        hintText: cartProvider.selectedPaymentOption,
                        items: const ['pagar_na_entrega', 'pago'],
                        onChanged: (val) {
                          cartProvider.selectedPaymentOption = val ?? 'pago';
                          cartProvider.updateUI();
                        },
                        displayItem: (val) => val);
                  },
                ),
                // Coupon Code Field
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        height: 60,
                        labelText: 'Digite o Cupom de Desconto',
                        onSave: (value) {},
                        controller: context.cartProvider.couponController,
                      ),
                    ),
                    ApplyCouponButton(onPressed: () {
                      context.cartProvider.checkCoupon();
                    })
                  ],
                ),
                //? Text for Total Amount, Total Offer Applied, and Grand Total
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 5, left: 6),
                  child: Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('SubTotal             : \$${cartProvider.getCartSubTotal()}',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                          Text('Desconto Total Aplicado  : \$${cartProvider.couponCodeDiscount}',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                          Text('Valor Final            : \$${context.cartProvider.getGrandTotal()}',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                        ],
                      );
                    },
                  ),
                ),
                const Divider(),
                //? Pay Button
                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    return CompleteOrderButton(
                        labelText: 'Finalizar Pedido  \$${context.cartProvider.getGrandTotal()} ',
                        onPressed: () {
                          if (!cartProvider.isExpanded) {
                            cartProvider.isExpanded = true;
                            cartProvider.updateUI();
                            return;
                          }
                          // Check if the form is valid
                          if (context.cartProvider.buyNowFormKey.currentState!.validate()) {
                            context.cartProvider.buyNowFormKey.currentState!.save();
                            context.cartProvider.submitOrder(context);
                            return;
                           }
                        });
                  },
                )
              ],
            ),
          ),
        ),
      );
    },
    isScrollControlled: true,
  );
}
