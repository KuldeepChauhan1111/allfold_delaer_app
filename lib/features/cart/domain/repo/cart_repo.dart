import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:sales_app/core/error/failure.dart';
import 'package:sales_app/features/cart/data/models/checkout_response.dart';

abstract class CartRepo {
  Future<Either<Failure, CheckoutResponse>> checkout(
      HashMap<String, dynamic> hashMap);
}
