import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:sales_app/core/domain/usecases/usecase.dart';
import 'package:sales_app/core/error/failure.dart';
import 'package:sales_app/features/favorites/data/models/get_favorite_list_response.dart';
import 'package:sales_app/features/favorites/domain/repo/favorite_repo.dart';

class GetFavoriteListUsecase
    extends UseCase<GetFavoriteListResponse, HashMap<String, dynamic>> {
  final FavoriteRepo repo;

  GetFavoriteListUsecase(this.repo);

  @override
  Future<Either<Failure, GetFavoriteListResponse>> call(
      HashMap<String, dynamic> params) {
    return repo.getFavoriteList(params);
  }
}
