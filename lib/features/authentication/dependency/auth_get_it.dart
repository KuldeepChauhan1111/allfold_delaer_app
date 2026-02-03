import 'package:get_it/get_it.dart';
import 'package:sales_app/core/dependency/global_get_it.dart';
import 'package:sales_app/features/authentication/data/repo_impl/authentication_repo_impl.dart';
import 'package:sales_app/features/authentication/domain/repo/authentication_repo.dart';
import 'package:sales_app/features/authentication/domain/usecase/authentication_usecase.dart';
import 'package:sales_app/features/authentication/domain/usecase/forgot_password_usecase.dart';
import 'package:sales_app/features/authentication/presentation/blocs/authentication_cubit.dart';

final GetIt authGetIt = GetIt.instance;

Future<void> setupAuthGetIt() async {
  authGetIt.registerFactory<AuthenticationCubit>(
    () => AuthenticationCubit(
      iPreference: globalGetIt(),
      authenticationUseCase: authGetIt(),
      forgotPasswordUseCase: authGetIt(),
    ),
  );

  authGetIt.registerFactory<AuthenticationRepo>(
    () => AuthenticationRepoImpl(remoteDataSource: globalGetIt()),
  );

  authGetIt.registerFactory<AuthenticationUseCase>(
    () => AuthenticationUseCase(globalGetIt()),
  );
  authGetIt.registerFactory<ForgotPasswordUseCase>(
    () => ForgotPasswordUseCase(globalGetIt()),
  );
}
