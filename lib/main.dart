import 'package:flutter/material.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/dependency/global_get_it.dart';
import 'package:sales_app/core/routes/app_router.dart';
import 'package:sales_app/features/authentication/dependency/auth_get_it.dart';
import 'package:sales_app/features/cart/dependency/cart_get_it.dart';
import 'package:sales_app/features/category/dependency/category_get_it.dart';
import 'package:sales_app/features/favorites/dependency/favorite_get_it.dart';
import 'package:sales_app/features/orders/dependency/order_get_it.dart';
import 'package:sales_app/features/product/dependency/product_get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  await initializeGetIt();
  runApp(const MyApp());
}

AppRouter _appRouterGlobal = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ALLFOLD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.colorWhite),
        scaffoldBackgroundColor: AppColors.colorTransparent,
        useMaterial3: true,
        fontFamily: AppConstants.fontFamilyRoboto,
        radioTheme: RadioThemeData(
          fillColor:
              WidgetStateColor.resolveWith((states) => AppColors.colorPrimary),
        ),
      ),
      routerConfig: _appRouterGlobal.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<void> initializeGetIt() async {
  await setupGlobalGetIt();
  await setupAuthGetIt();
  await setupCategoryGetIt();
  await setupProductGetIt();
  await setupCartGetIt();
  await setupOrderGetIt();
  await setupFavoriteGetIt();
}
