import 'package:get_it/get_it.dart';
import 'package:sales_app/core/dependency/global_get_it.dart';
import 'package:sales_app/features/cart/data/repo_impl/cart_repo_impl.dart';
import 'package:sales_app/features/cart/domain/repo/cart_repo.dart';
import 'package:sales_app/features/cart/domain/usecase/checkout_usecase.dart';
import 'package:sales_app/features/cart/presentation/blocs/cart_cubit.dart';

final GetIt cartGetIt = GetIt.instance;

Future<void> setupCartGetIt() async {
  cartGetIt.registerFactory<CartCubit>(
    () => CartCubit(
      iPreference: globalGetIt(),
      checkoutUsecase: cartGetIt(),
    ),
  );

  cartGetIt.registerFactory<CartRepo>(
    () => CartRepoImpl(remoteDataSource: globalGetIt()),
  );

  cartGetIt.registerFactory<CheckoutUsecase>(
    () => CheckoutUsecase(globalGetIt()),
  );
}
