import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:sales_app/core/domain/usecases/usecase.dart';
import 'package:sales_app/core/error/failure.dart';
import 'package:sales_app/features/orders/data/models/order_receive_response.dart';
import 'package:sales_app/features/orders/domain/repo/order_repo.dart';

class OrderReceiveUsecase
    extends UseCase<OrderReceiveResponse, HashMap<String, dynamic>> {
  final OrderRepo repo;

  OrderReceiveUsecase(this.repo);

  @override
  Future<Either<Failure, OrderReceiveResponse>> call(
      HashMap<String, dynamic> params) {
    return repo.orderReceive(params);
  }
}
