import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/constants/app_size_constants.dart';
import 'package:sales_app/core/constants/app_strings_constants.dart';
import 'package:sales_app/core/routes/app_router.gr.dart';
import 'package:sales_app/core/utils/app_extensions.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/core/widgets/card_widget.dart';
import 'package:sales_app/features/orders/data/models/get_order_list_response.dart';

class CommonOrderHistoryItemWidget extends StatefulWidget {
  const CommonOrderHistoryItemWidget({
    super.key,
    this.index,
    this.item,
    this.callBack,
  });

  final int? index;
  final OrderList? item;
  final Function? callBack;

  @override
  State<CommonOrderHistoryItemWidget> createState() =>
      _CommonOrderHistoryItemWidgetState();
}

class _CommonOrderHistoryItemWidgetState
    extends State<CommonOrderHistoryItemWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(

        borderRadius: BorderRadius.circular(12),
        onTap: () {
          AutoRouter.of(context)
              .push(OrderDetailsRoute(orderItem: widget.item))
              .then((val) {
            widget.callBack!();
          });
        },
        child: Container(
          // margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          padding:
              const EdgeInsets.only(left: 12, top: 12, bottom: 10, right: 12),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: 'Order #${widget.item?.order ?? ''}'.textWidget(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.colorLightGrey,
                          fontFamily: AppConstants.fontFamilyPoppins),
                    ),
                    "$currencySymbol${(widget.item?.amount?.amountTotal?.toStringAsFixed(2) ?? '')}"
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
                        child: (widget.item?.stateValue ?? '').textWidget(
                            color: AppColors.colorPrimary,
                            fontSize: 13,
                            fontFamily: AppConstants.fontFamilyPoppins,
                            fontWeight: FontWeight.w500),
                      ),
                      AppUtils.getDate(
                              date: "${widget.item?.date}", format: "MMM dd,yyyy")
                          .textWidget(
                              color: AppColors.colorLightGrey,
                              fontSize: 13,
                              fontFamily: AppConstants.fontFamilyPoppins,
                              fontWeight: FontWeight.w500)
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
