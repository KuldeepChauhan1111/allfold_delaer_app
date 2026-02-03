import 'package:flutter/material.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_size_constants.dart';
import 'package:sales_app/core/utils/app_extensions.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/core/widgets/common_button_widget.dart';

class CommonTwoBtnDialog extends StatefulWidget {
  final String? dialogTitle;
  final String? dialogMessage;
  final String? dialogBtnTextLeft;
  final String? dialogBtnTextRight;
  final VoidCallback? dialogBtnRightFnc;
  final VoidCallback? dialogBtnLeftFnc;
  final bool? rightPop;
  final bool? leftPop;

  const CommonTwoBtnDialog(
      {Key? key,
      this.dialogTitle,
      this.dialogMessage,
      this.dialogBtnTextLeft,
      this.dialogBtnTextRight,
      this.dialogBtnLeftFnc,
      this.dialogBtnRightFnc,
      this.leftPop,
      this.rightPop})
      : super(key: key);

  @override
  State<CommonTwoBtnDialog> createState() => _CommonDialogState();
}

class _CommonDialogState extends State<CommonTwoBtnDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.colorWhite,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(12.0),
      )),
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.85,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppUtils.commonSizedBox(height: 10),
            AppUtils.commonTextWidget(
                text: widget.dialogTitle?.toUpperCase() ?? "Error",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0,
                textColor: AppColors.colorPrimary),
            AppUtils.commonSizedBox(height: 20),
            AppUtils.commonTextWidget(
                textAlign: TextAlign.center,
                text: widget.dialogMessage ?? '',
                fontSize: fontSizeNormal,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
                textColor: AppColors.colorBg),
            30.toSizedBoxHeight,
            Row(
              children: [
                Expanded(
                    child: CommonButtonWidget(
                  buttonText: widget.dialogBtnTextLeft ?? "Cancel",
                   onPressed: () {
                    if (widget.dialogBtnLeftFnc != null) {
                      widget.dialogBtnLeftFnc!();
                    }
                    if (widget.leftPop ?? true) {
                      Navigator.pop(context);
                    }
                  },
                  verticalPadding: 10,
                  buttonBgColor: AppColors.colorBg,
                )),
                12.toSizedBoxWidth,
                Expanded(
                    child: CommonButtonWidget(
                  buttonText: widget.dialogBtnTextRight ?? "OKAY",
                      onPressed: () {
                        if (widget.dialogBtnRightFnc != null) {
                          widget.dialogBtnRightFnc!();
                        }
                        if (widget.rightPop ?? true) {
                          Navigator.pop(context);
                        }
                      },
                  verticalPadding: 10,
                )),
                // Expanded(
                //   child: AppUtils.commonElevatedBtn(
                //       onPressed: () {
                //         if (widget.dialogBtnLeftFnc != null) {
                //           widget.dialogBtnLeftFnc!();
                //         }
                //         if (widget.leftPop ?? true) {
                //           Navigator.pop(context);
                //         }
                //       },
                //       bgColor: AppColors.colorGrey,
                //       height: 45,
                //       textColor: AppColors.colorWhite,
                //       text: widget.dialogBtnTextLeft ?? "Cancel",
                //       fontWeight: FontWeight.bold,
                //       leftMargin: 0,
                //       rightMargin: 0,
                //       topMargin: 30,
                //       bottomMargin: 0),
                // ),

                // Expanded(
                //   child: AppUtils.commonElevatedBtn(
                //       onPressed: () {
                //         if (widget.dialogBtnRightFnc != null) {
                //           widget.dialogBtnRightFnc!();
                //         }
                //         if (widget.rightPop ?? true) {
                //           Navigator.pop(context);
                //         }
                //       },
                //       bgColor: AppColors.colorPrimary,
                //       fontWeight: FontWeight.bold,
                //       height: 45,
                //       textColor: AppColors.colorWhite,
                //       text: widget.dialogBtnTextRight ?? "OKAY",
                //       leftMargin: 0,
                //       rightMargin: 0,
                //       topMargin: 30,
                //       bottomMargin: 0),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
