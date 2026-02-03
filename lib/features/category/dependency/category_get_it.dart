import 'package:get_it/get_it.dart';
import 'package:sales_app/core/dependency/global_get_it.dart';
import 'package:sales_app/features/category/data/repo_impl/categories_repo_impl.dart';
import 'package:sales_app/features/category/domain/repo/categories_repo.dart';
import 'package:sales_app/features/category/domain/usecase/get_categories_usecase.dart';
import 'package:sales_app/features/category/presentation/blocs/categories_cubit.dart';

final GetIt categoryGetIt = GetIt.instance;

Future<void> setupCategoryGetIt() async {
  categoryGetIt.registerFactory<CategoriesCubit>(
    () => CategoriesCubit(
      iPreference: globalGetIt(),
      getCategoriesUseCase: categoryGetIt(),
    ),
  );

  categoryGetIt.registerFactory<CategoriesRepo>(
    () => CategoriesRepoImpl(remoteDataSource: globalGetIt()),
  );

  categoryGetIt.registerFactory<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(globalGetIt()),
  );
}
