import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:sales_app/core/error/failure.dart';
import 'package:sales_app/features/orders/data/models/get_order_list_response.dart';
import 'package:sales_app/features/orders/data/models/order_details_response.dart';
import 'package:sales_app/features/orders/data/models/order_picking_list_response.dart';
import 'package:sales_app/features/orders/data/models/order_receive_response.dart';
import 'package:sales_app/features/orders/data/models/update_order_response.dart';

abstract class OrderRepo {
  Future<Either<Failure, GetOrderListResponse>> getOrders(
      HashMap<String, dynamic> hashMap);
  Future<Either<Failure, OrderDetailsResponse>> getOrderDetails(
      HashMap<String, dynamic> hashMap);
  Future<Either<Failure, UpdateOrderResponse>> updateOrder(
      HashMap<String, dynamic> hashMap);
  Future<Either<Failure, OrderPickingListResponse>> orderPickingList(
      HashMap<String, dynamic> hashMap);
  Future<Either<Failure, OrderReceiveResponse>> orderReceive(
      HashMap<String, dynamic> hashMap);
}
