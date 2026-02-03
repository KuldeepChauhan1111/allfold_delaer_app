import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_size_constants.dart';
import 'package:sales_app/core/utils/app_extensions.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/core/widgets/common_button_widget.dart';
import 'package:sales_app/core/widgets/common_functions.dart';
import 'package:sales_app/features/orders/dependency/order_get_it.dart';
import 'package:sales_app/features/orders/presentation/blocs/order_cubit.dart';
import 'package:sales_app/features/orders/presentation/blocs/order_state.dart';
import 'package:sales_app/features/orders/presentation/pages/tabs/common_order_history_item_widget.dart';
import 'package:sales_app/features/product/presentation/pages/product_detail_screen.dart';

class TabUpcomingWidget extends StatefulWidget {
  const TabUpcomingWidget({super.key});

  @override
  State<TabUpcomingWidget> createState() => _TabUpcomingWidgetState();
}

class _TabUpcomingWidgetState extends State<TabUpcomingWidget> {
  late OrderCubit _orderCubit;

  @override
  void initState() {
    super.initState();
    _orderCubit = orderGetIt.get<OrderCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _orderCubit,
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          return Column(
            children: [
              AppUtils.commonSizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return const CommonOrderHistoryItemWidget();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _listItem(int index) {
    return Slidable(
        key: UniqueKey(),
        endActionPane: ActionPane(
          extentRatio: 0.20,
          dragDismissible: false,
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
              dismissalDuration: const Duration(milliseconds: 1000),
              dismissThreshold: 0.1,
              onDismissed: () {}),
          children: [
            SlidableAction(
              onPressed: (context) {
                AppUtils.showCustomTwoBtnDialog(
                  ctx: context,
                  dialogBtnTextRight: "Yes",
                  dialogBtnTextLeft: "No",
                  dialogMessage: "Are you sure you want to delete the user?",
                  dialogTitle: "Alert",
                  dialogBtnRightFnc: () {
                    showToastMsg('Deleted');
                  },
                );
              },
              borderRadius: BorderRadius.circular(15),
              backgroundColor: Colors.red,
              foregroundColor: AppColors.colorWhite,
              icon: Icons.delete_outline,
              // label: 'Delete',
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(productId: 0),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 80,
                      width: 75,
                      decoration: BoxDecoration(
                          color: AppColors.colorLightGrey,
                          borderRadius: BorderRadius.circular(10)),
                      // child: icPlaceholderUrl.toNetWorkImage(
                      //     borderRadius: 8, height: 65, width: 60),
                      child: ''.imageBase64(
                        height: 65,
                        width: 60,
                      ),
                    ),
                    // child: Icon(Icons.ac_unit, size: 50,)),
                    AppUtils.commonSizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          'Category Name'.textWidget(
                              fontSize: fontSizeMedium,
                              fontWeight: FontWeight.bold),
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  'Sub cat'.textWidget(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.colorPrimary),
                                  'Size'.richTextView(
                                      fontWeight: FontWeight.bold,
                                      textSpanList: [
                                        const WidgetSpan(
                                            child: SizedBox(width: 4)),
                                        const TextSpan(
                                            text: '10',
                                            style: TextStyle(
                                                color: AppColors.colorPrimary,
                                                fontWeight: FontWeight.bold))
                                      ]),
                                  'Type'.richTextView(
                                      fontWeight: FontWeight.bold,
                                      textSpanList: [
                                        const WidgetSpan(
                                            child: SizedBox(width: 4)),
                                        const TextSpan(
                                            text: '2 Step',
                                            style: TextStyle(
                                                color: AppColors.colorPrimary,
                                                fontWeight: FontWeight.bold))
                                      ]),
                                ],
                              )),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CommonButtonWidget(
                                    buttonText: 'Add to Cart',
                                    verticalPadding: 5,
                                    borderRadius: 4,
                                    fontSize: 12,
                                    onPressed: () {},
                                  ),
                                  5.toSizedBoxHeight,
                                  AppUtils.commonTextWidget(
                                      text: '< Swipe to remove',
                                      fontSize: 10,
                                      letterSpacing: 0.5,
                                      textColor: AppColors.colorPrimary)
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
