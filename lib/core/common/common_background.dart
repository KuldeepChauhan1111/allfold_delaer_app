import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sales_app/core/utils/app_utils.dart';

class CommonBackGround extends StatelessWidget {
  Widget? body;

  CommonBackGround({Key? key, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = AppUtils.getMediaHeight(context);
    final width = AppUtils.getMediaWidth(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AppUtils.commonContainer(
        height: height,
        width: width,
        decoration: AppUtils.commonBoxDecoration(
          color: Color(0xFF120E00),
        ),
        child: body,
      ),
    );
  }
}
