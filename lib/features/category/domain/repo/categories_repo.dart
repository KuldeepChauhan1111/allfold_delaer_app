import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:sales_app/core/error/failure.dart';
import 'package:sales_app/features/category/data/models/get_categories_response.dart';

abstract class CategoriesRepo {
  Future<Either<Failure, GetCategoriesResponse>> getCategories(
      HashMap<String, dynamic> hashMap);
}
