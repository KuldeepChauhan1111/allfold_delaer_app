import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:sales_app/core/domain/usecases/usecase.dart';
import 'package:sales_app/core/error/failure.dart';
import 'package:sales_app/features/orders/data/models/update_order_response.dart';
import 'package:sales_app/features/orders/domain/repo/order_repo.dart';

class UpdateOrdersUsecase
    extends UseCase<UpdateOrderResponse, HashMap<String, dynamic>> {
  final OrderRepo repo;

  UpdateOrdersUsecase(this.repo);

  @override
  Future<Either<Failure, UpdateOrderResponse>> call(
      HashMap<String, dynamic> params) {
    return repo.updateOrder(params);
  }
}
