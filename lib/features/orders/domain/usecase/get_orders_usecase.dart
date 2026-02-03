import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:sales_app/core/domain/usecases/usecase.dart';
import 'package:sales_app/core/error/failure.dart';
import 'package:sales_app/features/orders/data/models/get_order_list_response.dart';
import 'package:sales_app/features/orders/domain/repo/order_repo.dart';

class GetOrdersUsecase
    extends UseCase<GetOrderListResponse, HashMap<String, dynamic>> {
  final OrderRepo repo;

  GetOrdersUsecase(this.repo);

  @override
  Future<Either<Failure, GetOrderListResponse>> call(
      HashMap<String, dynamic> params) {
    return repo.getOrders(params);
  }
}
