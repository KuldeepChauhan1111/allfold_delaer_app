import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_size_constants.dart';
import 'package:sales_app/core/utils/app_extensions.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/core/utils/image_path.dart';
import 'package:sales_app/core/widgets/circle_loading_indicator_widget.dart';
import 'package:sales_app/core/widgets/common_button_widget.dart';
import 'package:sales_app/core/widgets/common_functions.dart';
import 'package:sales_app/features/orders/dependency/order_get_it.dart';
import 'package:sales_app/features/orders/presentation/blocs/order_cubit.dart';
import 'package:sales_app/features/orders/presentation/blocs/order_state.dart';
import 'package:sales_app/features/orders/presentation/pages/tabs/common_order_history_item_widget.dart';
import 'package:sales_app/features/product/presentation/pages/product_detail_screen.dart';

class TabPastWidget extends StatefulWidget {
  const TabPastWidget({super.key});

  @override
  State<TabPastWidget> createState() => _TabPastWidgetState();
}

class _TabPastWidgetState extends State<TabPastWidget> {
  late OrderCubit _orderCubit;

  @override
  void initState() {
    super.initState();
    _orderCubit = orderGetIt.get<OrderCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        _orderCubit.apiCallGetOrders(orderFilter: OrderStatusType.delivered);
        return _orderCubit;
      },
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          return state is LoadingState
              ? const CircleLoadingIndicatorWidget()
              : Column(
                  children: [
                    AppUtils.commonSizedBox(height: 10),
                    Expanded(
                      child: (_orderCubit.orderList ?? []).isEmpty
                          ? AppUtils.noDataWidget()
                          : ListView.builder(
                              itemCount: _orderCubit.orderList?.length ?? 0,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return CommonOrderHistoryItemWidget(
                                  index: index,
                                  item: _orderCubit.orderList?[index],
                                  callBack: () {
                                    _orderCubit.apiCallGetOrders(
                                        orderFilter: OrderStatusType.delivered);
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
