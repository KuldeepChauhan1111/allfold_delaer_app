import 'package:flutter/material.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/utils/app_utils.dart';

class CommonDialog extends StatefulWidget {
  final String? dialogTitle;
  final String? dialogMessage;
  final String? dialogBtnText;
  const CommonDialog({Key? key, this.dialogTitle, this.dialogMessage, this.dialogBtnText}) : super(key: key);

  @override
  State<CommonDialog> createState() => _CommonDialogState();
}

class _CommonDialogState extends State<CommonDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.colorWhite,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppUtils.commonTextWidget(
              text: widget.dialogTitle ?? "Error",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              textColor: AppColors.colorPrimary),
          AppUtils.commonSizedBox(height: 20),
          AppUtils.commonTextWidget(
              text: widget.dialogMessage ?? '',
              textAlign: TextAlign.center,
              letterSpacing: 1,
              textColor: AppColors.colorSecondary),
          AppUtils.commonElevatedBtn(
              onPressed: (){Navigator.pop(context);},
              bgColor: AppColors.colorPrimary,
              height: 45,
              textColor: AppColors.colorWhite,
              text: widget.dialogBtnText ?? "OKAY",
              leftMargin: 0,
              rightMargin: 0,
              topMargin: 30,
              bottomMargin: 0)
        ],
      ),
    );;
  }
}
