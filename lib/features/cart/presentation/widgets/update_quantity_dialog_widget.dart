import 'package:flutter/material.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/utils/app_extensions.dart';
import 'package:sales_app/core/widgets/common_button_widget.dart';
import 'package:sales_app/core/widgets/common_functions.dart';
import 'package:sales_app/core/widgets/custom_text_form_field.dart';

class UpdateQuantityDialogWidget extends StatelessWidget {
  const UpdateQuantityDialogWidget({
    super.key,
    required this.qtyTextEditingController,
    required this.positiveCallBack,
  });

  final TextEditingController qtyTextEditingController;
  final Function(String val) positiveCallBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.75,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            10.toSizedBoxHeight,
            CustomTextFormField(
              controller: qtyTextEditingController,
              hintText: "Qty",
              autofocus: true,
              inputFormatterRegex: '[0-9]',
              inputType: TextInputType.number,
              hintColor: AppColors.colorWhite,
              fillColor: AppColors.colorBg,
              textColor: AppColors.colorWhite,
              borderColor: AppColors.colorWhite,
              isShowBorder: true,
              maxLines: 1,
              maxLength: 4,
              onChanged: (value) {},
            ),
            24.toSizedBoxHeight,
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
                        verticalPadding: 10,
                        buttonText: 'Update',
                        onPressed: () {
                          if (int.parse(qtyTextEditingController.text
                                  .trim()
                                  .toString()) ==
                              0) {
                            showToastMsg('Quantity should not be zero');
                          } else {
                            positiveCallBack(qtyTextEditingController.text);
                            Navigator.pop(context);
                          }
                        })),
              ],
            ),
            10.toSizedBoxHeight,
          ],
        ));
  }
}
