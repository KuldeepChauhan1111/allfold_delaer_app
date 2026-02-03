import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:sales_app/core/error/failure.dart';
import 'package:sales_app/features/authentication/data/models/login_response.dart';

abstract class AuthenticationRepo {
  Future<Either<Failure, LoginResponse>> login(
      HashMap<String, dynamic> hashMap);

  Future<Either<Failure, LoginResponse>> forgotPassword(
      HashMap<String, dynamic> hashMap);
}
