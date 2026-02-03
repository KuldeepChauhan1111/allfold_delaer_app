import 'package:flutter/material.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_size_constants.dart';
import 'package:sales_app/core/utils/app_extensions.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    super.key,
    this.msg,
  });

  final String? msg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: (msg ?? 'No data available').textWidget(fontWeight: FontWeight.bold, color: AppColors.colorWhite),
      ),
    );
  }
}
