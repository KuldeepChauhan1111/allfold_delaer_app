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
import 'package:sales_app/features/cart/data/models/checkout_response.dart';
import 'package:sales_app/features/cart/domain/repo/cart_repo.dart';

class CartRepoImpl implements CartRepo {
  final IRemoteDataSource remoteDataSource;

  CartRepoImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, CheckoutResponse>> checkout(
      HashMap<String, dynamic> hashMap) async {
    try {
      IResponse res = await remoteDataSource.executePost(
          path: ApiConstants.checkout, requestBody: jsonEncode(hashMap));
      ResponseModel responseModel = res as ResponseModel;
      CheckoutResponse resImpl = CheckoutResponse.fromJson(res.toJson());
      if (kDebugMode) {
        print('logcat :: api response = $resImpl');
      }
      if (responseModel.isError == 'false' &&
          responseModel.isValidationFailed == 'false') {
        return Right(resImpl);
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
