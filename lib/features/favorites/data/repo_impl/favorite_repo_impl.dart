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
import 'package:sales_app/features/favorites/data/models/get_favorite_list_response.dart';
import 'package:sales_app/features/favorites/domain/repo/favorite_repo.dart';

class FavoriteRepoImpl implements FavoriteRepo {
  final IRemoteDataSource remoteDataSource;

  FavoriteRepoImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, GetFavoriteListResponse>> getFavoriteList(
      HashMap<String, dynamic> hashMap) async {
    try {
      IResponse res = await remoteDataSource.executePost(
          path: ApiConstants.favouriteList, requestBody: jsonEncode(hashMap));
      ResponseModel responseModel = res as ResponseModel;
      GetFavoriteListResponse implRes =
          GetFavoriteListResponse.fromJson(res.toJson());
      if (kDebugMode) {
        print('logcat :: api response = $implRes');
      }
      if (responseModel.isError == 'false' &&
          responseModel.isValidationFailed == 'false') {
        return Right(implRes);
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
