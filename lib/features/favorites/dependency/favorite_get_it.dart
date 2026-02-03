import 'package:get_it/get_it.dart';
import 'package:sales_app/core/dependency/global_get_it.dart';
import 'package:sales_app/features/favorites/data/repo_impl/favorite_repo_impl.dart';
import 'package:sales_app/features/favorites/domain/repo/favorite_repo.dart';
import 'package:sales_app/features/favorites/domain/usecase/get_favorite_list_usecase.dart';
import 'package:sales_app/features/favorites/presentation/blocs/favorite_cubit.dart';

final GetIt favoriteGetIt = GetIt.instance;

Future<void> setupFavoriteGetIt() async {
  favoriteGetIt.registerFactory<FavoriteCubit>(
    () => FavoriteCubit(
      iPreference: globalGetIt(),
      getFavoriteListUsecase: favoriteGetIt(),
    ),
  );

  favoriteGetIt.registerFactory<FavoriteRepo>(
    () => FavoriteRepoImpl(remoteDataSource: globalGetIt()),
  );

  favoriteGetIt.registerFactory<GetFavoriteListUsecase>(
    () => GetFavoriteListUsecase(globalGetIt()),
  );
}
