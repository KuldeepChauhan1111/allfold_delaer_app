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
import 'package:sales_app/features/authentication/data/models/login_response.dart';
import 'package:sales_app/features/authentication/domain/repo/authentication_repo.dart';

class AuthenticationRepoImpl implements AuthenticationRepo {
  final IRemoteDataSource remoteDataSource;

  AuthenticationRepoImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, LoginResponse>> login(
      HashMap<String, dynamic> hashMap) async {
    try {
      IResponse res = await remoteDataSource.executePost(
          path: ApiConstants.login, requestBody: jsonEncode(hashMap));
      ResponseModel responseModel = res as ResponseModel;
      LoginResponse logRes = LoginResponse.fromJson(res.toJson());
      if (kDebugMode) {
        print('logcat :: api response = $logRes');
      }

      if (responseModel.isError == 'false' &&
          responseModel.isValidationFailed == 'false') {
        return Right(logRes);
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
  Future<Either<Failure, LoginResponse>> forgotPassword(
      HashMap<String, dynamic> hashMap) async {
    try {
      IResponse res = await remoteDataSource.executePost(
          path: ApiConstants.forgotPassword, requestBody: jsonEncode(hashMap));
      ResponseModel responseModel = res as ResponseModel;
      LoginResponse logRes = LoginResponse.fromJson(res.toJson());
      if (kDebugMode) {
        print('logcat :: api response = $logRes');
      }
      if (responseModel.isError == 'false' &&
          responseModel.isValidationFailed == 'false') {
        return Right(logRes);
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
