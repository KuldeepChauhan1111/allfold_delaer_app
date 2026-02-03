// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/foundation.dart' as _i14;
import 'package:flutter/material.dart' as _i16;
import 'package:sales_app/features/authentication/presentation/pages/forgot_password_screen.dart'
    as _i3;
import 'package:sales_app/features/authentication/presentation/pages/login_screen.dart'
    as _i4;
import 'package:sales_app/features/authentication/presentation/pages/splash_screen.dart'
    as _i11;
import 'package:sales_app/features/cart/presentation/pages/cart_screen.dart'
    as _i1;
import 'package:sales_app/features/category/data/models/get_categories_response.dart'
    as _i20;
import 'package:sales_app/features/category/presentation/blocs/categories_cubit.dart'
    as _i19;
import 'package:sales_app/features/category/presentation/pages/sub_category_screen.dart'
    as _i12;
import 'package:sales_app/features/dashboard/presentation/pages/dashboard_screen.dart'
    as _i2;
import 'package:sales_app/features/orders/data/models/get_order_list_response.dart'
    as _i15;
import 'package:sales_app/features/orders/data/models/order_picking_list_response.dart'
    as _i17;
import 'package:sales_app/features/orders/presentation/pages/order_details_screen.dart'
    as _i5;
import 'package:sales_app/features/orders/presentation/pages/order_reciever_screen.dart'
    as _i6;
import 'package:sales_app/features/product/data/models/product_details_response.dart'
    as _i18;
import 'package:sales_app/features/product/presentation/pages/product_detail_screen.dart'
    as _i7;
import 'package:sales_app/features/product/presentation/pages/product_list_screen.dart'
    as _i8;
import 'package:sales_app/features/product/presentation/pages/product_preview_screen.dart'
    as _i9;
import 'package:sales_app/features/profile/presentation/pages/profile_screen.dart'
    as _i10;

/// generated route for
/// [_i1.CartScreen]
class CartRoute extends _i13.PageRouteInfo<void> {
  const CartRoute({List<_i13.PageRouteInfo>? children})
    : super(CartRoute.name, initialChildren: children);

  static const String name = 'CartRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i1.CartScreen();
    },
  );
}

/// generated route for
/// [_i2.DashboardScreen]
class DashboardRoute extends _i13.PageRouteInfo<void> {
  const DashboardRoute({List<_i13.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i2.DashboardScreen();
    },
  );
}

/// generated route for
/// [_i3.ForgotPasswordScreen]
class ForgotPasswordRoute extends _i13.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i13.PageRouteInfo>? children})
    : super(ForgotPasswordRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i3.ForgotPasswordScreen();
    },
  );
}

/// generated route for
/// [_i4.LogInScreen]
class LogInRoute extends _i13.PageRouteInfo<void> {
  const LogInRoute({List<_i13.PageRouteInfo>? children})
    : super(LogInRoute.name, initialChildren: children);

  static const String name = 'LogInRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i4.LogInScreen();
    },
  );
}

/// generated route for
/// [_i5.OrderDetailsScreen]
class OrderDetailsRoute extends _i13.PageRouteInfo<OrderDetailsRouteArgs> {
  OrderDetailsRoute({
    _i14.Key? key,
    _i15.OrderList? orderItem,
    List<_i13.PageRouteInfo>? children,
  }) : super(
         OrderDetailsRoute.name,
         args: OrderDetailsRouteArgs(key: key, orderItem: orderItem),
         initialChildren: children,
       );

  static const String name = 'OrderDetailsRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderDetailsRouteArgs>(
        orElse: () => const OrderDetailsRouteArgs(),
      );
      return _i5.OrderDetailsScreen(key: args.key, orderItem: args.orderItem);
    },
  );
}

class OrderDetailsRouteArgs {
  const OrderDetailsRouteArgs({this.key, this.orderItem});

  final _i14.Key? key;

  final _i15.OrderList? orderItem;

  @override
  String toString() {
    return 'OrderDetailsRouteArgs{key: $key, orderItem: $orderItem}';
  }
}

/// generated route for
/// [_i6.OrderReceiveScreen]
class OrderReceiveRoute extends _i13.PageRouteInfo<OrderReceiveRouteArgs> {
  OrderReceiveRoute({
    _i16.Key? key,
    required _i17.PickingData? pickingData,
    int? orderId,
    bool? isStatusDelivered,
    List<_i13.PageRouteInfo>? children,
  }) : super(
         OrderReceiveRoute.name,
         args: OrderReceiveRouteArgs(
           key: key,
           pickingData: pickingData,
           orderId: orderId,
           isStatusDelivered: isStatusDelivered,
         ),
         initialChildren: children,
       );

  static const String name = 'OrderReceiveRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderReceiveRouteArgs>();
      return _i6.OrderReceiveScreen(
        key: args.key,
        pickingData: args.pickingData,
        orderId: args.orderId,
        isStatusDelivered: args.isStatusDelivered,
      );
    },
  );
}

class OrderReceiveRouteArgs {
  const OrderReceiveRouteArgs({
    this.key,
    required this.pickingData,
    this.orderId,
    this.isStatusDelivered,
  });

  final _i16.Key? key;

  final _i17.PickingData? pickingData;

  final int? orderId;

  final bool? isStatusDelivered;

  @override
  String toString() {
    return 'OrderReceiveRouteArgs{key: $key, pickingData: $pickingData, orderId: $orderId, isStatusDelivered: $isStatusDelivered}';
  }
}

/// generated route for
/// [_i7.ProductDetailScreen]
class ProductDetailRoute extends _i13.PageRouteInfo<ProductDetailRouteArgs> {
  ProductDetailRoute({
    _i16.Key? key,
    required int productId,
    List<_i13.PageRouteInfo>? children,
  }) : super(
         ProductDetailRoute.name,
         args: ProductDetailRouteArgs(key: key, productId: productId),
         initialChildren: children,
       );

  static const String name = 'ProductDetailRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailRouteArgs>();
      return _i7.ProductDetailScreen(key: args.key, productId: args.productId);
    },
  );
}

class ProductDetailRouteArgs {
  const ProductDetailRouteArgs({this.key, required this.productId});

  final _i16.Key? key;

  final int productId;

  @override
  String toString() {
    return 'ProductDetailRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i8.ProductListScreen]
class ProductListRoute extends _i13.PageRouteInfo<ProductListRouteArgs> {
  ProductListRoute({
    _i14.Key? key,
    required int? categoryId,
    required String? categoryName,
    List<_i13.PageRouteInfo>? children,
  }) : super(
         ProductListRoute.name,
         args: ProductListRouteArgs(
           key: key,
           categoryId: categoryId,
           categoryName: categoryName,
         ),
         initialChildren: children,
       );

  static const String name = 'ProductListRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductListRouteArgs>();
      return _i8.ProductListScreen(
        key: args.key,
        categoryId: args.categoryId,
        categoryName: args.categoryName,
      );
    },
  );
}

class ProductListRouteArgs {
  const ProductListRouteArgs({
    this.key,
    required this.categoryId,
    required this.categoryName,
  });

  final _i14.Key? key;

  final int? categoryId;

  final String? categoryName;

  @override
  String toString() {
    return 'ProductListRouteArgs{key: $key, categoryId: $categoryId, categoryName: $categoryName}';
  }
}

/// generated route for
/// [_i9.ProductPreviewScreen]
class ProductPreviewRoute extends _i13.PageRouteInfo<ProductPreviewRouteArgs> {
  ProductPreviewRoute({
    _i14.Key? key,
    _i18.ProductInfo? productInfo,
    List<_i13.PageRouteInfo>? children,
  }) : super(
         ProductPreviewRoute.name,
         args: ProductPreviewRouteArgs(key: key, productInfo: productInfo),
         initialChildren: children,
       );

  static const String name = 'ProductPreviewRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductPreviewRouteArgs>(
        orElse: () => const ProductPreviewRouteArgs(),
      );
      return _i9.ProductPreviewScreen(
        key: args.key,
        productInfo: args.productInfo,
      );
    },
  );
}

class ProductPreviewRouteArgs {
  const ProductPreviewRouteArgs({this.key, this.productInfo});

  final _i14.Key? key;

  final _i18.ProductInfo? productInfo;

  @override
  String toString() {
    return 'ProductPreviewRouteArgs{key: $key, productInfo: $productInfo}';
  }
}

/// generated route for
/// [_i10.ProfileScreen]
class ProfileRoute extends _i13.PageRouteInfo<void> {
  const ProfileRoute({List<_i13.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i10.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i11.SplashScreen]
class SplashRoute extends _i13.PageRouteInfo<void> {
  const SplashRoute({List<_i13.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i11.SplashScreen();
    },
  );
}

/// generated route for
/// [_i12.SubCategoryScreen]
class SubCategoryRoute extends _i13.PageRouteInfo<SubCategoryRouteArgs> {
  SubCategoryRoute({
    _i16.Key? key,
    required _i19.CategoriesCubit categoriesCubit,
    _i20.Categories? categoryItem,
    List<_i13.PageRouteInfo>? children,
  }) : super(
         SubCategoryRoute.name,
         args: SubCategoryRouteArgs(
           key: key,
           categoriesCubit: categoriesCubit,
           categoryItem: categoryItem,
         ),
         initialChildren: children,
       );

  static const String name = 'SubCategoryRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SubCategoryRouteArgs>();
      return _i12.SubCategoryScreen(
        key: args.key,
        categoriesCubit: args.categoriesCubit,
        categoryItem: args.categoryItem,
      );
    },
  );
}

class SubCategoryRouteArgs {
  const SubCategoryRouteArgs({
    this.key,
    required this.categoriesCubit,
    this.categoryItem,
  });

  final _i16.Key? key;

  final _i19.CategoriesCubit categoriesCubit;

  final _i20.Categories? categoryItem;

  @override
  String toString() {
    return 'SubCategoryRouteArgs{key: $key, categoriesCubit: $categoriesCubit, categoryItem: $categoryItem}';
  }
}
