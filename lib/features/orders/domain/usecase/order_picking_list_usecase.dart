import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:sales_app/core/domain/usecases/usecase.dart';
import 'package:sales_app/core/error/failure.dart';
import 'package:sales_app/features/orders/data/models/order_picking_list_response.dart';
import 'package:sales_app/features/orders/domain/repo/order_repo.dart';

class OrderPickingListUsecase
    extends UseCase<OrderPickingListResponse, HashMap<String, dynamic>> {
  final OrderRepo repo;

  OrderPickingListUsecase(this.repo);

  @override
  Future<Either<Failure, OrderPickingListResponse>> call(
      HashMap<String, dynamic> params) {
    return repo.orderPickingList(params);
  }
}
