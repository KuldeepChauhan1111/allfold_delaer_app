import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:sales_app/core/domain/usecases/usecase.dart';
import 'package:sales_app/core/error/failure.dart';
import 'package:sales_app/features/cart/data/models/checkout_response.dart';
import 'package:sales_app/features/cart/domain/repo/cart_repo.dart';

class CheckoutUsecase
    extends UseCase<CheckoutResponse, HashMap<String, dynamic>> {
  final CartRepo repo;

  CheckoutUsecase(this.repo);

  @override
  Future<Either<Failure, CheckoutResponse>> call(
      HashMap<String, dynamic> params) {
    return repo.checkout(params);
  }
}
