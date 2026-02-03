import 'package:get_it/get_it.dart';
import 'package:sales_app/core/dependency/global_get_it.dart';
import 'package:sales_app/features/product/data/repo_impl/product_repo_impl.dart';
import 'package:sales_app/features/product/domain/repo/product_repo.dart';
import 'package:sales_app/features/product/domain/usecase/favorite_unfavorite_usecase.dart';
import 'package:sales_app/features/product/domain/usecase/get_products_by_categories_usecase.dart';
import 'package:sales_app/features/product/domain/usecase/products_details_usecase.dart';
import 'package:sales_app/features/product/presentation/blocs/product_cubit.dart';

final GetIt productGetIt = GetIt.instance;

Future<void> setupProductGetIt() async {
  productGetIt.registerFactory<ProductCubit>(
    () => ProductCubit(
      iPreference: globalGetIt(),
      getProductsByCategoriesUseCase: productGetIt(),
      productsDetailsUsecase: productGetIt(),
      favoriteUnFavoriteUsecase: productGetIt(),
    ),
  );

  productGetIt.registerFactory<ProductRepo>(
    () => ProductRepoImpl(remoteDataSource: globalGetIt()),
  );

  productGetIt.registerFactory<GetProductsByCategoriesUseCase>(
    () => GetProductsByCategoriesUseCase(globalGetIt()),
  );

  productGetIt.registerFactory<ProductsDetailsUsecase>(
    () => ProductsDetailsUsecase(globalGetIt()),
  );

  productGetIt.registerFactory<FavoriteUnfavoriteUsecase>(
    () => FavoriteUnfavoriteUsecase(globalGetIt()),
  );
}
