import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:sales_app/core/data/datasources/i_remote_ds.dart';
import 'package:sales_app/core/data/datasources/remote_ds_impl.dart';
import 'package:sales_app/core/storage/i_preference.dart';
import 'package:sales_app/core/storage/preference_impl.dart';
import 'package:sales_app/core/utils/network_info.dart';

final GetIt globalGetIt = GetIt.instance;

Future<void> setupGlobalGetIt() async {
  globalGetIt.registerLazySingleton(
    // () => InternetConnectionChecker(),
    () => InternetConnection(),
  );

  globalGetIt.registerLazySingleton<IPreference>(
    () => PreferenceImpl(),
  );

  globalGetIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      globalGetIt(),
    ),
  );

  globalGetIt.registerLazySingleton(
    () => http.Client(),
  );

  globalGetIt.registerLazySingleton<IRemoteDataSource>(
    () => RemoteDataSourceImpl(
      client: globalGetIt(),
    ),
  );
}
