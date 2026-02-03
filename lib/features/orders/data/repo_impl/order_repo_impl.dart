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
import 'package:sales_app/features/orders/data/models/get_order_list_response.dart';
import 'package:sales_app/features/orders/data/models/order_details_response.dart';
import 'package:sales_app/features/orders/data/models/order_picking_list_response.dart';
import 'package:sales_app/features/orders/data/models/order_receive_response.dart';
import 'package:sales_app/features/orders/data/models/update_order_response.dart';
import 'package:sales_app/features/orders/domain/repo/order_repo.dart';

class OrderRepoImpl implements OrderRepo {
  final IRemoteDataSource remoteDataSource;

  OrderRepoImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, GetOrderListResponse>> getOrders(
      HashMap<String, dynamic> hashMap) async {
    try {
      IResponse res = await remoteDataSource.executePost(
          path: ApiConstants.getOrders, requestBody: jsonEncode(hashMap));
      ResponseModel responseModel = res as ResponseModel;
      GetOrderListResponse implRes =
          GetOrderListResponse.fromJson(res.toJson());
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

  @override
  Future<Either<Failure, OrderDetailsResponse>> getOrderDetails(
      HashMap<String, dynamic> hashMap) async {
    try {
      IResponse res = await remoteDataSource.executePost(
          path: ApiConstants.getOrderDetails, requestBody: jsonEncode(hashMap));
      ResponseModel responseModel = res as ResponseModel;
      OrderDetailsResponse implRes =
          OrderDetailsResponse.fromJson(res.toJson());
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
            isUnauthorized: responseModel.code == 401,
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
  Future<Either<Failure, UpdateOrderResponse>> updateOrder(
      HashMap<String, dynamic> hashMap) async {
    try {
      IResponse res = await remoteDataSource.executePost(
          path: ApiConstants.updateOrder, requestBody: jsonEncode(hashMap));
      ResponseModel responseModel = res as ResponseModel;
      UpdateOrderResponse implRes = UpdateOrderResponse.fromJson(res.toJson());
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

  @override
  Future<Either<Failure, OrderPickingListResponse>> orderPickingList(
      HashMap<String, dynamic> hashMap) async {
    try {
      IResponse res = await remoteDataSource.executePost(
          path: ApiConstants.orderPicking, requestBody: jsonEncode(hashMap));
      ResponseModel responseModel = res as ResponseModel;
      OrderPickingListResponse implRes =
          OrderPickingListResponse.fromJson(res.toJson());
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

  @override
  Future<Either<Failure, OrderReceiveResponse>> orderReceive(
      HashMap<String, dynamic> hashMap) async {
    try {
      IResponse res = await remoteDataSource.executePost(
          path: ApiConstants.orderReceive, requestBody: jsonEncode(hashMap));
      ResponseModel responseModel = res as ResponseModel;
      OrderReceiveResponse implRes =
          OrderReceiveResponse.fromJson(res.toJson());
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
