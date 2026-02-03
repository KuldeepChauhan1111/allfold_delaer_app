import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:sales_app/core/error/failure.dart';
import 'package:sales_app/features/favorites/data/models/get_favorite_list_response.dart';

abstract class FavoriteRepo {
  Future<Either<Failure, GetFavoriteListResponse>> getFavoriteList(
      HashMap<String, dynamic> hashMap);
}
