import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/constants/app_size_constants.dart';
import 'package:sales_app/core/constants/app_strings_constants.dart';
import 'package:sales_app/core/utils/app_extensions.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/core/widgets/app_bar_widget2.dart';
import 'package:sales_app/core/widgets/common_functions.dart';
import 'package:sales_app/core/widgets/no_data_widget.dart';
import 'package:sales_app/features/orders/data/models/order_picking_list_response.dart';
import 'package:sales_app/features/orders/dependency/order_get_it.dart';
import 'package:sales_app/features/orders/presentation/blocs/order_cubit.dart';
import 'package:sales_app/features/orders/presentation/widgets/receive_order_dialog_widget.dart';

@RoutePage()
class OrderReceiveScreen extends StatefulWidget {
  bool? isStatusDelivered;
  PickingData? pickingData;
  int? orderId;

  OrderReceiveScreen({super.key, required this.pickingData, this.orderId,this.isStatusDelivered});

  @override
  State<OrderReceiveScreen> createState() => _OrderReceiveScreenState();
}

class _OrderReceiveScreenState extends State<OrderReceiveScreen> {
  late OrderCubit _orderCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _orderCubit = orderGetIt.get<OrderCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, appBarSize),
        child: AppBarWidget2(
          title: titleOrderReceiveScreen,
          isBackVisible: true,
          isCartVisible: false,
          onBackPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: [
                5.toSizedBoxHeight,
                _orderInfoView(),
                _divider(),
                _headingText("Transporter Details"),
                5.toSizedBoxHeight,
                _transporterDetail(),
                _divider(),
                _headingText("Delivered List"),
                5.toSizedBoxHeight,
                _orderList(),
              ],
            ),
          ),
          // widget.isStatusDelivered == false ? _btnCheckout(onSwipe: _showAlertDialogOrderReceive) : SizedBox(),
          widget.isStatusDelivered == false ?  AppUtils.slideButton(onSwipe: _showAlertDialogOrderReceive, context: context,
              text: "Receive Order"

          ) : SizedBox(),
        ],
      ),
    );
  }

  Widget _headingText(String text){
    return text.textWidget(
      fontWeight: FontWeight.bold,
      fontSize: fontSizeExtraLarge,
      color: AppColors.colorWhite,
    );
  }

  Widget _divider(){
    return Column(
      children: [
        10.toSizedBoxHeight,
        Divider(
          thickness: 0.2,
          color: AppColors.colorLightGrey.withOpacity(0.9),
        ),
        10.toSizedBoxHeight,
      ],
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
                Expanded(
                  child: '${widget.pickingData?.deliveryOrder}'.textWidget(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.colorLightGrey,
                      fontFamily: AppConstants.fontFamilyPoppins),
                ),
                10.toSizedBoxHeight,
                Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: "${widget.pickingData?.status?.toUpperCase()}"
                            .textWidget(
                                color: AppColors.colorPrimary,
                                fontSize: 13,
                                fontFamily: AppConstants.fontFamilyPoppins,
                                fontWeight: FontWeight.w500),
                      ),
                      AppUtils.getDate(
                              date: "2021-01-01 01:01:01",
                              format: "MMM dd,yyyy")
                          .textWidget(
                              color: AppColors.colorLightGrey,
                              fontSize: 13,
                              fontFamily: AppConstants.fontFamilyPoppins,
                              fontWeight: FontWeight.w500)
                    ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderList() {
    return (widget.pickingData?.products ?? []).isEmpty
        ? const Padding(
            padding: EdgeInsets.all(10.0),
            child: NoDataWidget(),
          )
        : ListView.builder(
            itemCount: (widget.pickingData?.products ?? []).length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Products? item = widget.pickingData?.products?[index];
              // int? productId = _orderCubit.productId[index];

              return _listItemOrderItem(item);
            });
  }

  Widget _listItemOrderItem(Products? item) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
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
                child: '${item?.productName}'.textWidget(
                    fontWeight: FontWeight.bold,
                    fontFamily: AppConstants.fontFamilyPoppins,
                    fontSize: fontSizeMedium,
                    color: AppColors.colorLightGrey),
              ),
              'Qty :'.richTextView(textSpanList: [
                const WidgetSpan(child: SizedBox(width: 3)),
                TextSpan(
                  text: '${item?.quantity?.toInt()}',
                  style: const TextStyle(
                      color: AppColors.colorPrimary,
                      fontWeight: FontWeight.bold),
                ),
              ]),
            ],
          ),
          // 5.toSizedBoxHeight,
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     Expanded(
          //       child: Row(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           2.toSizedBoxHeight,
          //           'Qty :'.richTextView(textSpanList: [
          //             const WidgetSpan(child: SizedBox(width: 3)),
          //             TextSpan(
          //               text: '${item?.quantity}',
          //               style: const TextStyle(
          //                   color: AppColors.colorPrimary,
          //                   fontWeight: FontWeight.bold),
          //             ),
          //           ]),
          //           2.toSizedBoxHeight,
          //           ' | $lblSteps :'.richTextView(textSpanList: [
          //             const WidgetSpan(child: SizedBox(width: 3)),
          //             TextSpan(
          //               text:
          //               item?.productVariant?.steps?.name ?? 'N/A',
          //               style: const TextStyle(
          //                   color: AppColors.colorPrimary,
          //                   fontWeight: FontWeight.bold),
          //             ),
          //           ]),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          // 5.toSizedBoxHeight,
          // Row(
          //   children: [
          //     Expanded(
          //       child: (item?.productVariant?.material?.name ?? 'N/A')
          //           .textWidget(
          //           fontWeight: FontWeight.w400,
          //           fontFamily: AppConstants.fontFamilyRoboto,
          //           fontSize: 13,
          //           color: AppColors.colorWhite),
          //     ),
          //     '$currencySymbol${item?.priceIncludeTax?.toStringAsFixed(2)}'
          //         .textWidget(
          //         fontWeight: FontWeight.bold,
          //         fontFamily: AppConstants.fontFamilyRoboto,
          //         fontSize: fontSizeNormal,
          //         color: AppColors.colorLightGrey),
          //   ],
          // ),
        ],
      ),
    );
  }
  //
  // Widget _btnCheckout({required Function onSwipe}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 16.0),
  //     child: SliderButton(
  //       height: 70,
  //       vibrationFlag: true,
  //       shimmer: true,
  //       action: () async {
  //         await onSwipe();
  //         return false;
  //       },
  //       label: Center(
  //         child: "Receive Order".textWidget(
  //           fontWeight: FontWeight.w600,
  //           fontSize: 16,
  //           textAlign: TextAlign.center,
  //         ),
  //       ),
  //       width: MediaQuery.of(context).size.width * 0.90,
  //       radius: 360,
  //       highlightedColor: Colors.white,
  //       child: Container(
  //         width: 70,
  //         height: 70,
  //         decoration: BoxDecoration(
  //           gradient: LinearGradient(
  //             colors: [
  //               AppColors.gradient1,
  //               AppColors.gradient2,
  //             ],
  //             begin: Alignment.topLeft,
  //             end: Alignment.bottomRight,
  //           ),
  //           borderRadius: BorderRadius.circular(360),
  //         ),
  //         child: Icon(
  //           Icons.done,
  //           color: AppColors.colorLightGrey,
  //           size: 30,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _transporterDetail() {
    return (widget.pickingData?.transpoter ==
            null) ||
                        (widget.pickingData?.transpoter?.driverName == "") ||
                        (widget.pickingData?.transpoter?.vehicleNumber == "") ||
                        (widget.pickingData?.transpoter?.driverContact == "") ||
                        (widget.pickingData?.transpoter?.notes == "")
        ? const Padding(
            padding: EdgeInsets.all(10.0),
            child: NoDataWidget(
              msg: "No transporter found",
            ),
          )
        : Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child:
                          (widget.pickingData?.transpoter?.driverName ?? "")
                              .textWidget(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AppConstants.fontFamilyPoppins,
                                  fontSize: fontSizeMedium,
                                  color: AppColors.colorLightGrey),
                    ),
                    (widget.pickingData?.transpoter?.vehicleNumber ?? "")
                        .textWidget(
                            fontWeight: FontWeight.w500,
                            fontFamily: AppConstants.fontFamilyPoppins,
                            fontSize: fontSizeSmall,
                            color: AppColors.colorLightGrey),
                  ],
                ),
                5.toSizedBoxHeight,
                ("+91 ${widget.pickingData?.transpoter?.driverContact}" ?? "")
                    .textWidget(
                        fontWeight: FontWeight.w500,
                        fontFamily: AppConstants.fontFamilyPoppins,
                        fontSize: fontSizeSmall,
                        color: AppColors.colorLightGrey),
                5.toSizedBoxHeight,
                (widget.pickingData?.transpoter?.notes ?? "")
                    .textWidget(
                        fontWeight: FontWeight.w800,
                        fontFamily: AppConstants.fontFamilyPoppins,
                        fontSize: fontSizeSmall,
                        fonStyle: FontStyle.italic,
                        color: AppColors.colorLightGrey),
              ],
            ),
          );
  }

  void _showAlertDialogOrderReceive() {
    showAlertDialog(
      context: context,
      title: titleOrderReceive,
      isTitleCenter: true,
      widget: ReceiveOrderDialogWidget(
        productList: widget.pickingData?.products,
        positiveCallBack: () {
          List<Map<String, dynamic>>? productline = widget.pickingData?.products
              ?.map<Map<String, dynamic>>((element) {
            return {
              'productid': element.productId,
              'stock': element.quantity,
            };
          }).toList();

          // Convert list to the required single-quote string format
          String? formattedProductline = productline
              ?.map((e) =>
                  "{'productid': ${e['productid']}, 'stock': ${e['stock']}}")
              .join(',');

          String productlineString = "[$formattedProductline]";

          print("formatedString $productlineString");

          _orderCubit.apiCallOrderReceive(
            context: context,
              orderId: widget.orderId,
              receiptNo: widget.pickingData?.deliveryOrder,
              productLine: productlineString);
        },
      ),
    );
  }
}
