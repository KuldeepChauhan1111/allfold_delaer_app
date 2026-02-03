import 'package:auto_route/auto_route.dart';
import 'package:sales_app/core/routes/app_router.gr.dart';
import 'package:sales_app/features/category/presentation/pages/sub_category_screen.dart';
import 'package:sales_app/features/orders/presentation/pages/order_details_screen.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
// class AppRouter extends $AppRouter {
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> routes = [
    AutoRoute(path: RouteConstant.splashScreen, page: SplashRoute.page),
    AutoRoute(path: RouteConstant.loginScreen, page: LogInRoute.page),
    AutoRoute(
        path: RouteConstant.forgotPasswordScreen,
        page: ForgotPasswordRoute.page),
    AutoRoute(path: RouteConstant.dashboardScreen, page: DashboardRoute.page),
    AutoRoute(path: RouteConstant.myProfileScreen, page: ProfileRoute.page),
    AutoRoute(path: RouteConstant.subCategoryScreen, page: SubCategoryRoute.page),
    AutoRoute(path: RouteConstant.cartScreen, page: CartRoute.page),
    AutoRoute(
        path: RouteConstant.productListScreen, page: ProductListRoute.page),
    AutoRoute(
        path: RouteConstant.productDetailsScreen,
        page: ProductDetailRoute.page),
    AutoRoute(
        path: RouteConstant.productPreviewScreen,
        page: ProductPreviewRoute.page),
    AutoRoute(
        path: RouteConstant.orderDetailsScreen,
        page: OrderDetailsRoute.page),
    AutoRoute(
        path: RouteConstant.orderReceiveScreen,
        page: OrderReceiveRoute.page),
  ];
}

class RouteConstant {
  static const splashScreen = '/';
  static const loginScreen = '/login';
  static const forgotPasswordScreen = '/forgotPassword';
  static const dashboardScreen = '/dashboard';
  static const myProfileScreen = '/myProfile';
  static const subCategoryScreen = '/subCategory';
  static const cartScreen = '/cart';
  static const productListScreen = '/productList';
  static const productDetailsScreen = '/productDetails';
  static const productPreviewScreen = '/productPreview';
  static const orderDetailsScreen = '/orderDetails';
  static const orderReceiveScreen = '/orderReceive';
}
