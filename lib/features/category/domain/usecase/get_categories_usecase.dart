import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:sales_app/core/domain/usecases/usecase.dart';
import 'package:sales_app/core/error/failure.dart';
import 'package:sales_app/features/category/data/models/get_categories_response.dart';
import 'package:sales_app/features/category/domain/repo/categories_repo.dart';

class GetCategoriesUseCase
    extends UseCase<GetCategoriesResponse, HashMap<String, dynamic>> {
  final CategoriesRepo repo;

  GetCategoriesUseCase(this.repo);

  @override
  Future<Either<Failure, GetCategoriesResponse>> call(
      HashMap<String, dynamic> params) {
    return repo.getCategories(params);
  }
}
