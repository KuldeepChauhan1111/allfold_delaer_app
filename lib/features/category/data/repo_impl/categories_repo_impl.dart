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
import 'package:sales_app/features/category/data/models/get_categories_response.dart';
import 'package:sales_app/features/category/domain/repo/categories_repo.dart';

class CategoriesRepoImpl implements CategoriesRepo {
  final IRemoteDataSource remoteDataSource;

  CategoriesRepoImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, GetCategoriesResponse>> getCategories(
      HashMap<String, dynamic> hashMap) async {
    try {
      IResponse res = await remoteDataSource.executePost(
          path: ApiConstants.getCategories, requestBody: jsonEncode(hashMap));
      ResponseModel responseModel = res as ResponseModel;
      GetCategoriesResponse getCatRes =
          GetCategoriesResponse.fromJson(res.toJson());
      if (kDebugMode) {
        print('logcat :: api response = $getCatRes');
      }
      if (responseModel.isError == 'false' &&
          responseModel.isValidationFailed == 'false') {
        return Right(getCatRes);
      } else {
        if (kDebugMode) {
          print('logcat :: api response else : ${responseModel.code}');
        }
        return Left(
          AppFailure(
            errorMessages:
                responseModel.message ?? ErrorMessages.errorResponseIsNull,
            statusCodes: ErrorCodes.errorAtRepository,
            isUnauthorized: responseModel.code == 401 ||
                (responseModel.message ?? '').toLowerCase() ==
                    'token expired' ||
                (responseModel.message ?? '').toLowerCase() == 'token invalid',
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
