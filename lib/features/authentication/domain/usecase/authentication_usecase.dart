import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:sales_app/core/domain/usecases/usecase.dart';
import 'package:sales_app/core/error/failure.dart';
import 'package:sales_app/features/authentication/data/models/login_response.dart';
import 'package:sales_app/features/authentication/domain/repo/authentication_repo.dart';

class AuthenticationUseCase
    extends UseCase<LoginResponse, HashMap<String, dynamic>> {
  final AuthenticationRepo repo;

  AuthenticationUseCase(this.repo);

  @override
  Future<Either<Failure, LoginResponse>> call(HashMap<String, dynamic> params) {
    return repo.login(params);
  }
}
