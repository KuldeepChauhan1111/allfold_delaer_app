import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:sales_app/core/error/failure.dart';
import 'package:sales_app/features/product/data/models/favorite_response.dart';
import 'package:sales_app/features/product/data/models/get_product_by_categories_request.dart';
import 'package:sales_app/features/product/data/models/get_product_by_categories_response.dart';
import 'package:sales_app/features/product/data/models/product_details_request.dart';
import 'package:sales_app/features/product/data/models/product_details_response.dart';

abstract class ProductRepo {
  Future<Either<Failure, GetProductByCategoriesResponse>> getProductByCategory(
      GetProductByCategoriesRequest params);

  Future<Either<Failure, ProductDetailsResponse>> getProductDetails(
      ProductDetailsRequest params);

  Future<Either<Failure, FavoriteResponse>> favoriteUnFavorite(
      HashMap<String, dynamic> hashMap);
}
