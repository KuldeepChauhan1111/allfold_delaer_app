import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:sales_app/core/domain/usecases/usecase.dart';
import 'package:sales_app/core/error/failure.dart';
import 'package:sales_app/features/orders/data/models/order_details_response.dart';
import 'package:sales_app/features/orders/domain/repo/order_repo.dart';

class OrderDetailsUsecase
    extends UseCase<OrderDetailsResponse, HashMap<String, dynamic>> {
  final OrderRepo repo;

  OrderDetailsUsecase(this.repo);

  @override
  Future<Either<Failure, OrderDetailsResponse>> call(
      HashMap<String, dynamic> params) {
    return repo.getOrderDetails(params);
  }
}
