import 'dart:collection';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sales_app/core/constants/api_constants.dart';
import 'package:sales_app/core/data/datasources/i_remote_ds.dart';
import 'package:sales_app/core/error/error_codes.dart';
import 'package:sales_app/core/error/failure.dart';
import 'package:sales_app/core/model/i_response.dart';
import 'package:sales_app/core/model/response_model.dart';
import 'package:sales_app/features/product/data/models/favorite_response.dart';
import 'package:sales_app/features/product/data/models/get_product_by_categories_request.dart';
import 'package:sales_app/features/product/data/models/get_product_by_categories_response.dart';
import 'package:sales_app/features/product/data/models/product_details_request.dart';
import 'package:sales_app/features/product/data/models/product_details_response.dart';
import 'package:sales_app/features/product/domain/repo/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  final IRemoteDataSource remoteDataSource;

  ProductRepoImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, GetProductByCategoriesResponse>> getProductByCategory(
      GetProductByCategoriesRequest params) async {
    try {
      IResponse res = await remoteDataSource.executePost(
          path: '${ApiConstants.getProductsByCategory}/${params.categoryId}',
          requestBody: jsonEncode(HashMap.from({'token': params.token})));
      ResponseModel responseModel = res as ResponseModel;
      GetProductByCategoriesResponse getRes =
          GetProductByCategoriesResponse.fromJson(res.toJson());
      if (kDebugMode) {
        print('logcat :: api response = $getRes');
      }
      if (responseModel.isError == 'false' &&
          responseModel.isValidationFailed == 'false') {
        return Right(getRes);
      } else {
        if (kDebugMode) {
          print('logcat :: api response else');
        }
        return Left(
          AppFailure(
            errorMessages:
                responseModel.message ?? ErrorMessages.errorResponseIsNull,
            statusCodes: ErrorCodes.errorAtRepository,
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('logcat :: api response catch');
      }
      return Left(
        AppFailure(
          errorMessages: e.toString(),
          statusCodes: ErrorCodes.errorAtRepository,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ProductDetailsResponse>> getProductDetails(
      ProductDetailsRequest params) async {
    try {
      IResponse res = await remoteDataSource.executePost(
          path: '${ApiConstants.getProductDetails}/${params.productId}',
          requestBody: jsonEncode(HashMap.from({
            'token': params.token,
            'product_attribute_values': params.productAttributeValues,
          })));
      ResponseModel responseModel = res as ResponseModel;
      ProductDetailsResponse getRes =
          ProductDetailsResponse.fromJson(res.toJson());
      if (kDebugMode) {
        print('logcat :: api response = $getRes');
      }
      if (responseModel.isError == 'false' &&
          responseModel.isValidationFailed == 'false') {
        return Right(getRes);
      } else {
        if (kDebugMode) {
          print('logcat :: api response else');
        }
        return Left(
          AppFailure(
            errorMessages:
                responseModel.message ?? ErrorMessages.errorResponseIsNull,
            statusCodes: ErrorCodes.errorAtRepository,
            isUnauthorized: null,
            isNoInternetConnection: null,
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('logcat :: api response catch');
      }
      return Left(
        AppFailure(
          errorMessages: e.toString(),
          statusCodes: ErrorCodes.errorAtRepository,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, FavoriteResponse>> favoriteUnFavorite(
      HashMap<String, dynamic> hashMap) async {
    try {
      IResponse res = await remoteDataSource.executePost(
          path: ApiConstants.favouriteUnFavorite,
          requestBody: jsonEncode(hashMap));
      ResponseModel responseModel = res as ResponseModel;
      FavoriteResponse getRes = FavoriteResponse.fromJson(res.toJson());
      if (kDebugMode) {
        print('logcat :: api response = $getRes');
      }
      if (responseModel.isError == 'false' &&
          responseModel.isValidationFailed == 'false') {
        return Right(getRes);
      } else {
        if (kDebugMode) {
          print('logcat :: api response else');
        }
        return Left(
          AppFailure(
            errorMessages:
                responseModel.message ?? ErrorMessages.errorResponseIsNull,
            statusCodes: ErrorCodes.errorAtRepository,
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('logcat :: api response catch');
      }
      return Left(
        AppFailure(
          errorMessages: e.toString(),
          statusCodes: ErrorCodes.errorAtRepository,
        ),
      );
    }
  }
}
