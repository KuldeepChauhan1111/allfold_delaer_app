class ApiConstants {
  // static String baseUrl = 'https://jupicaltech-epistic1-sb-13841903.dev.odoo.com';
  // static String baseUrl = 'jupicaltech-epistic1-sb-13841903.dev.odoo.com';
  // static String baseUrl = 'jupicaltech-epistic-sb-14407573.dev.odoo.com';
  // static String baseUrl = 'jupicaltech-epistic-live.odoo.com';
  // static String baseUrl = 'staging-allfold.odoo.com';
  static String baseUrl = 'allfold.odoo.com';

  static String login = '/epistic/user';
  static String refreshToken = '/epistic/refreshToken';
  static String forgotPassword =
      '/epistic/'; // Todo static set forgot password url
  static String getCategories = '/epistic/categories';
  static String getProductsByCategory = '/epistic/category';
  static String getProductDetails = '/epistic/product';
  static String favouriteUnFavorite = '/epistic/product/favourite';
  static String favouriteList = '/epistic/product/favourite/distributor';
  static String checkout = '/epistic/order';
  static String getOrders = '/epistic/distributor/orders';
  static String getOrderDetails = '/epistic/distributor/order-details';
  static String updateOrder = '/epistic/order/update';
  static String orderPicking = '/epistic/order/pickings';
  static String orderReceive = '/epistic/stock/receive';
}
