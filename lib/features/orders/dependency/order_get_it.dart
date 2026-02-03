import 'package:get_it/get_it.dart';
import 'package:sales_app/core/dependency/global_get_it.dart';
import 'package:sales_app/features/orders/data/repo_impl/order_repo_impl.dart';
import 'package:sales_app/features/orders/domain/repo/order_repo.dart';
import 'package:sales_app/features/orders/domain/usecase/get_orders_usecase.dart';
import 'package:sales_app/features/orders/domain/usecase/order_details_usecase.dart';
import 'package:sales_app/features/orders/domain/usecase/order_picking_list_usecase.dart';
import 'package:sales_app/features/orders/domain/usecase/order_receive_usecase.dart';
import 'package:sales_app/features/orders/domain/usecase/update_orders_usecase.dart';
import 'package:sales_app/features/orders/presentation/blocs/order_cubit.dart';

final GetIt orderGetIt = GetIt.instance;

Future<void> setupOrderGetIt() async {
  orderGetIt.registerFactory<OrderCubit>(
    () => OrderCubit(
      iPreference: globalGetIt(),
      getOrdersUsecase: orderGetIt(),
      orderDetailsUsecase: orderGetIt(),
      updateOrdersUsecase: orderGetIt(),
      orderPickingListUsecase: orderGetIt(),
      orderReceiveUsecase: orderGetIt(),
    ),
  );

  orderGetIt.registerFactory<OrderRepo>(
    () => OrderRepoImpl(remoteDataSource: globalGetIt()),
  );

  orderGetIt.registerFactory<GetOrdersUsecase>(
    () => GetOrdersUsecase(globalGetIt()),
  );
  orderGetIt.registerFactory<OrderDetailsUsecase>(
    () => OrderDetailsUsecase(globalGetIt()),
  );
  orderGetIt.registerFactory<UpdateOrdersUsecase>(
    () => UpdateOrdersUsecase(globalGetIt()),
  );
  orderGetIt.registerFactory<OrderPickingListUsecase>(
    () => OrderPickingListUsecase(globalGetIt()),
  );
  orderGetIt.registerFactory<OrderReceiveUsecase>(
    () => OrderReceiveUsecase(globalGetIt()),
  );
}
