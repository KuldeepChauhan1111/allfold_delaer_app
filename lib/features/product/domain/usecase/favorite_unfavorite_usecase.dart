import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:sales_app/core/domain/usecases/usecase.dart';
import 'package:sales_app/core/error/failure.dart';
import 'package:sales_app/features/product/data/models/favorite_response.dart';
import 'package:sales_app/features/product/domain/repo/product_repo.dart';

class FavoriteUnfavoriteUsecase
    extends UseCase<FavoriteResponse, HashMap<String, dynamic>> {
  final ProductRepo repo;

  FavoriteUnfavoriteUsecase(this.repo);

  @override
  Future<Either<Failure, FavoriteResponse>> call(
      HashMap<String, dynamic> params) {
    return repo.favoriteUnFavorite(params);
  }
}
