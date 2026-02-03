import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/constants/app_size_constants.dart';
import 'package:sales_app/core/constants/app_strings_constants.dart';
import 'package:sales_app/core/routes/app_router.gr.dart';
import 'package:sales_app/core/utils/app_extensions.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/core/widgets/app_bar_widget.dart';
import 'package:sales_app/core/widgets/app_bar_widget2.dart';
import 'package:sales_app/core/widgets/card_widget.dart';
import 'package:sales_app/core/widgets/circle_loading_indicator_widget.dart';
import 'package:sales_app/core/widgets/common_button_widget.dart';
import 'package:sales_app/core/widgets/common_functions.dart';
import 'package:sales_app/core/widgets/no_data_widget.dart';
import 'package:sales_app/features/cart/data/models/checkout_req_model.dart';
import 'package:sales_app/features/cart/presentation/widgets/update_quantity_dialog_widget.dart';
import 'package:sales_app/features/orders/data/models/order_details_response.dart'
    as od;
import 'package:sales_app/features/orders/data/models/get_order_list_response.dart';
import 'package:sales_app/features/orders/data/models/order_picking_list_response.dart'
    as op;
import 'package:sales_app/features/orders/dependency/order_get_it.dart';
import 'package:sales_app/features/orders/presentation/blocs/order_cubit.dart';
import 'package:sales_app/features/orders/presentation/blocs/order_state.dart';
import 'package:sales_app/features/orders/presentation/pages/order_reciever_screen.dart';
import 'package:sales_app/features/orders/presentation/widgets/receive_order_dialog_widget.dart';

@RoutePage()
class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({
    super.key,
    this.orderItem,
  });

  final OrderList? orderItem;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
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
        _orderCubit.apiCallGetOrderDetails(orderId: widget.orderItem?.orderId);
        return _orderCubit;
      },
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (kDebugMode) {
            print('logcat :: status key == ${_orderCubit.orderDetails?.state}');
          }

          return AppScaffold(
            appBar: PreferredSize(
              preferredSize: const Size(double.infinity, appBarSize),
              child: AppBarWidget2(
                title: titleOrderDetails,
                isBackVisible: true,
                isCartVisible: false,
                onBackPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ),
            body: Stack(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        5.toSizedBoxHeight,
                        _orderInfoView(),
                        10.toSizedBoxHeight,
                        Divider(
                          thickness: 0.2,
                          color: AppColors.colorLightGrey.withOpacity(0.9),
                        ),
                        10.toSizedBoxHeight,
                        ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            'Product List'.textWidget(
                              fontWeight: FontWeight.bold,
                              fontSize: fontSizeExtraLarge,
                              color: AppColors.colorWhite,
                            ),
                            5.toSizedBoxHeight,
                            _orderList(),
                            10.toSizedBoxHeight,
                            Divider(
                              thickness: 0.2,
                              color: AppColors.colorLightGrey.withOpacity(0.9),
                            ),
                            10.toSizedBoxHeight,
                            lblOrderReceive.textWidget(
                              fontWeight: FontWeight.bold,
                              fontSize: fontSizeExtraLarge,
                              color: AppColors.colorWhite,
                            ),
                            5.toSizedBoxHeight,
                            _orderReceiveList(),
                            10.toSizedBoxHeight,
                            Divider(
                              thickness: 0.2,
                              color: AppColors.colorLightGrey.withOpacity(0.9),
                            ),
                            10.toSizedBoxHeight,
                            // Spacer(),
                            _subTotalView()
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const CircleLoadingIndicatorWidget()
                    .toVisibility(state is LoadingState),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _subTotalView() {
    return Visibility(
      visible: _orderCubit.orderDetails?.products != null,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.colorBg, // background color for visibility
          borderRadius: BorderRadius.circular(12), // rounded corners
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            'Order Summary'.textWidget(
              fontWeight: FontWeight.bold,
              fontSize: fontSizeExtraLarge,
              color: AppColors.colorWhite,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const Spacer(),
                '$lblSubtotal (${_orderCubit.cartTotalQty} Items) : '
                    .textWidget(
                  color: AppColors.colorWhite,
                  fontWeight: FontWeight.w600,
                  fontSize: fontSizeNormal,
                ),
                '$currencySymbol${_orderCubit.cartSubtotal.toStringAsFixed(2)}'
                    .textWidget(
                        color: AppColors.colorWhite,
                        fontSize: fontSizeMedium,
                        fontFamily: AppConstants.fontFamilyRoboto,
                        fontWeight: FontWeight.bold
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Gst (18%) : '.textWidget(
                  color: AppColors.colorWhite,
                  fontWeight: FontWeight.w600,
                  fontSize: fontSizeNormal,
                ),
                '$currencySymbol${_orderCubit.cartGstTotal.toStringAsFixed(2)}'
                    .textWidget(
                        color: AppColors.colorWhite,
                        fontSize: fontSizeMedium,
                        fontFamily: AppConstants.fontFamilyRoboto,
                        fontWeight: FontWeight.bold)
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Total : '.textWidget(
                  color: AppColors.colorWhite,
                  fontWeight: FontWeight.w600,
                  fontSize: fontSizeNormal,
                ),
                '$currencySymbol${_orderCubit.cartTotal.toStringAsFixed(2)}'
                    .textWidget(
                        color: AppColors.colorPrimary,
                        fontSize: fontSizeMedium,
                        fontFamily: AppConstants.fontFamilyRoboto,
                        fontWeight: FontWeight.bold)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _orderInfoView() {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: 'Order #${_orderCubit.orderDetails?.order ?? ''}'
                          .textWidget(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.colorLightGrey,
                              fontFamily: AppConstants.fontFamilyPoppins),
                    ),
                    "$currencySymbol${(_orderCubit.orderDetails?.amount?.amountTotal?.toStringAsFixed(2) ?? 00)}"
                        .textWidget(
                            color: AppColors.colorPrimary,
                            fontSize: 15,
                            fontFamily: AppConstants.fontFamilyRoboto,
                            fontWeight: FontWeight.bold),
                  ],
                ),
                10.toSizedBoxHeight,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: (_orderCubit.orderDetails?.stateValue ?? '')
                          .textWidget(
                              color: AppColors.colorPrimary,
                              fontSize: 13,
                              fontFamily: AppConstants.fontFamilyPoppins,
                              fontWeight: FontWeight.w500),
                    ),
                    AppUtils.getDate(
                            date: "${_orderCubit.orderDetails?.date}",
                            format: "MMM dd,yyyy")
                        .textWidget(
                            color: AppColors.colorLightGrey,
                            fontSize: 13,
                            fontFamily: AppConstants.fontFamilyPoppins,
                            fontWeight: FontWeight.w500)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderList() {
    return (_orderCubit.orderDetails?.products ?? []).isEmpty
        ? const Padding(
            padding: EdgeInsets.all(10.0),
            child: NoDataWidget(),
          )
        : ListView.builder(
            itemCount: (_orderCubit.orderDetails?.products ?? []).length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              od.Products? item = _orderCubit.orderDetails?.products?[index];
              // int? productId = _orderCubit.productId[index];

              return _listItemOrderItem(item);
            });
  }

  Widget _orderReceiveList() {
    return (_orderCubit.orderPickingListResponse?.data ?? []).isEmpty
        ? const Padding(
            padding: EdgeInsets.all(10.0),
            child: NoDataWidget(),
          )
        : ListView.builder(
            itemCount:
                (_orderCubit.orderPickingListResponse?.data ?? []).length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              op.PickingData? item =
                  _orderCubit.orderPickingListResponse?.data?[index];
              print(
                  "------------------${_orderCubit.orderPickingListResponse?.data?[index].status}");

              return _listItemOrderPickingItem(item);
            });
  }

  Widget _listItemOrderItem(od.Products? item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      child: Slidable(
          key: UniqueKey(),
          endActionPane: _orderCubit.isAllowUpdateOrder
              ? ActionPane(
                  extentRatio: 0.5,
                  dragDismissible: false,
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(
                      dismissalDuration: const Duration(milliseconds: 1000),
                      dismissThreshold: 0.1,
                      onDismissed: () {}),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        if (_orderCubit.isAllowUpdateOrder) {
                          _orderCubit.qtyEditController.clear();
                          _orderCubit.qtyEditController.text =
                              (item?.quantity ?? 1).toString();
                          _showAlertDialogUpdateQuantity(item?.id);
                        }
                      },
                      borderRadius: BorderRadius.circular(12),
                      backgroundColor: AppColors.colorPrimary,
                      foregroundColor: AppColors.colorWhite,
                      icon: Icons.edit,
                      // label: 'Delete',
                    ),
                    4.toSizedBoxWidth,
                    SlidableAction(
                      onPressed: (context) {
                        AppUtils.showCustomTwoBtnDialog(
                          ctx: context,
                          dialogBtnTextRight: lblYes,
                          dialogBtnTextLeft: lblNo,
                          dialogMessage: msgRemoveProductFromOrder,
                          dialogTitle: lblAlert,
                          dialogBtnRightFnc: () {
                            hideKeyBoard();
                            _orderCubit.apiCallUpdateQuantity(
                              orderId: widget.orderItem?.orderId,
                              productId: item?.id,
                              qty: 0,
                            );
                          },
                        );
                      },
                      borderRadius: BorderRadius.circular(12),
                      backgroundColor: Colors.red,
                      foregroundColor: AppColors.colorWhite,
                      icon: Icons.delete_outline,
                      // label: 'Delete',
                    ),
                  ],
                )
              : null,
          child: InkWell(
            onTap: () {
              // if (_orderCubit.orderDetails?.state == OrderStatusType.draft) {
              if (_orderCubit.isAllowUpdateOrder) {
                _orderCubit.qtyEditController.clear();
                _orderCubit.qtyEditController.text =
                    (item?.quantity ?? 1).toString();
                _showAlertDialogUpdateQuantity(item?.id);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.colorBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.colorPrimary.withOpacity(0.25),
                    blurRadius: 0,
                    spreadRadius: 0.0,
                    offset: const Offset(0, 1.5),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 30,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: '${item?.name}'.textWidget(
                            fontWeight: FontWeight.bold,
                            fontFamily: AppConstants.fontFamilyPoppins,
                            fontSize: fontSizeMedium,
                            color: AppColors.colorLightGrey),
                      ),
                      (item?.productStatus ?? "").textWidget(
                          fontWeight: FontWeight.w400,
                          fontFamily: AppConstants.fontFamilyRoboto,
                          fontSize: 13,
                          color: AppColors.colorPrimary),
                    ],
                  ),
                  5.toSizedBoxHeight,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            2.toSizedBoxHeight,
                            'Qty :'.richTextView(textSpanList: [
                              const WidgetSpan(child: SizedBox(width: 3)),
                              TextSpan(
                                text: '${item?.quantity?.toInt()}',
                                style: const TextStyle(
                                    color: AppColors.colorPrimary,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                            2.toSizedBoxHeight,
                            ' | $lblSteps :'.richTextView(textSpanList: [
                              const WidgetSpan(child: SizedBox(width: 3)),
                              TextSpan(
                                text:
                                    item?.productVariant?.steps?.name ?? 'N/A',
                                style: const TextStyle(
                                    color: AppColors.colorPrimary,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                  5.toSizedBoxHeight,
                  Row(
                    children: [
                      Expanded(
                        child: (item?.productVariant?.material?.name ?? 'N/A')
                            .textWidget(
                                fontWeight: FontWeight.w400,
                                fontFamily: AppConstants.fontFamilyRoboto,
                                fontSize: 13,
                                color: AppColors.colorWhite),
                      ),
                      '$currencySymbol${item?.priceIncludeTax?.toStringAsFixed(2)}'
                          .textWidget(
                              fontWeight: FontWeight.bold,
                              fontFamily: AppConstants.fontFamilyRoboto,
                              fontSize: fontSizeNormal,
                              color: AppColors.colorLightGrey),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget _listItemOrderPickingItem(op.PickingData? item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.colorBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
          boxShadow: [
            BoxShadow(
              color: AppColors.colorPrimary.withOpacity(0.25),
              blurRadius: 0,
              spreadRadius: 0.0,
              offset: const Offset(0, 1.5),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 30,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            2.toSizedBoxHeight,
            Row(
              children: [
                Expanded(
                  child: '${item?.deliveryOrder} '.textWidget(
                    fontWeight: FontWeight.bold,
                    fontFamily: AppConstants.fontFamilyPoppins,
                    color: AppColors.colorLightGrey,
                    fontSize: fontSizeNormal,
                  ),
                ),
                2.toSizedBoxWidth,
                ''.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: (_orderCubit.orderDetails?.stateValue ?? '')
                            .textWidget(
                          color: AppColors.colorPrimary,
                          fontSize: fontSizeMedium,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : CommonButtonWidget(
                        buttonText: item?.status == AppConstants.statusDelivered.toLowerCase() ? 'View Details' :  "Receive",

                        onPressed: (){
                          AutoRouter.of(context).push(OrderReceiveRoute(
                              pickingData: item,
                              orderId:
                              _orderCubit.orderDetails?.orderId,
                            isStatusDelivered: item?.status == AppConstants.statusDelivered.toLowerCase() ?  true :false
                          )).then((value) {
                            _orderCubit.apiCallOrderPickings(orderId: widget.orderItem?.orderId);
                          },);
                        },
                        verticalPadding: 10,
                        borderRadius: 6,
                      ),
              ],
            ),
            2.toSizedBoxHeight,
          ],
        ),
      ),
    );
  }

  void _showAlertDialogUpdateQuantity(int? productId) {
    showAlertDialog(
      context: context,
      title: titleUpdateQuantity,
      isTitleCenter: true,
      widget: UpdateQuantityDialogWidget(
        qtyTextEditingController: _orderCubit.qtyEditController,
        positiveCallBack: (val) {
          _orderCubit.apiCallUpdateQuantity(
            orderId: widget.orderItem?.orderId,
            productId: productId,
            qty: int.parse(val),
          );
        },
      ),
    );
  }
}
