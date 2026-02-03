import 'package:flutter/material.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_size_constants.dart';
import 'package:sales_app/core/constants/app_strings_constants.dart';
import 'package:sales_app/core/utils/app_extensions.dart';
import 'package:sales_app/core/widgets/card_widget.dart';
import 'package:sales_app/core/widgets/common_button_widget.dart';
import 'package:sales_app/features/orders/data/models/order_picking_list_response.dart';

class ReceiveOrderDialogWidget extends StatelessWidget {
  const ReceiveOrderDialogWidget({
    super.key,
    this.productList,
    required this.positiveCallBack,
  });

  final List<Products>? productList;
  final Function() positiveCallBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.95,
        child: ListView(
          shrinkWrap: true,
          children: [
            12.toSizedBoxHeight,
            ListView.builder(
                itemCount: (productList ?? []).length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  print("productQty${productList?[index].quantity?.toInt()}");
                  return _listItem(
                      productList?[index]);
                }),
            16.toSizedBoxHeight,

            Row(
              children: [
                Expanded(
                    child: CommonButtonWidget(
                      borderRadius: 10,
                      buttonText: "Cancel",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      verticalPadding: 10,
                      buttonBgColor: AppColors.colorBg,
                    )),
                12.toSizedBoxWidth,
                Expanded(
                    child: CommonButtonWidget(
                      borderRadius: 10,
                      buttonText: btnAccept ?? "OKAY",
                      onPressed: () {
                        positiveCallBack();
                        Navigator.pop(context);
                      },
                      verticalPadding: 10,
                    )),
              ],
            ),
            // CommonButtonWidget(
            //   buttonText: btnAccept,
            //   onPressed: () {
            //
            //     positiveCallBack();
            //     Navigator.pop(context);
            //   },
            // ),
            10.toSizedBoxHeight,
          ],
        ));
  }

  Widget _listItem(Products? item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: '${item?.productName}'.textWidget(
                fontWeight: FontWeight.bold,
                fontSize: fontSizeNormal + 1,
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
