import 'package:mekto/screen/product_list_screen/provider/product_list_provider.dart';

import 'screen/home_screen.dart';
import 'screen/login_screen/login_screen.dart';
import 'screen/login_screen/provider/user_provider.dart';
import 'screen/product_by_category_screen/provider/product_by_category_provider.dart';
import 'screen/product_cart_screen/provider/cart_provider.dart';
import 'screen/product_details_screen/provider/product_detail_provider.dart';
import 'screen/product_favorite_screen/provider/favorite_provider.dart';
import 'screen/profile_screen/provider/profile_provider.dart';
import 'utility/app_theme.dart';
import 'utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/cart.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'dart:ui' show PointerDeviceKind;
import 'package:provider/provider.dart';
import 'core/data/data_provider.dart';
import 'models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  var cart = FlutterCart();
  OneSignal.initialize("4f3c0799-4bba-4d05-ba87-d935917e0d23");
  OneSignal.Notifications.requestPermission(true);
  await cart.initializeCart(isPersistenceSupportEnabled: true);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(
            create: (context) => UserProvider(context.dataProvider)),
        ChangeNotifierProvider(
            create: (context) => ProfileProvider(context.dataProvider)),
        ChangeNotifierProvider(
            create: (context) =>
                ProductByCategoryProvider(context.dataProvider)),
        ChangeNotifierProvider(
            create: (context) => ProductDetailProvider(context.dataProvider)),
        ChangeNotifierProvider(
            create: (context) => CartProvider(context.userProvider)),
        ChangeNotifierProvider(
            create: (context) => ProductListProvider(context.dataProvider)),
        ChangeNotifierProvider(
            create: (context) => FavoriteProvider(context.dataProvider)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    User? loginUser = context.userProvider.getLoginUsr();
    return GetMaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      debugShowCheckedModeBanner: false,
      home: loginUser?.sId == null ? const HomeScreen() : const HomeScreen(),
      theme: AppTheme.lightAppTheme,
    );
  }
}
