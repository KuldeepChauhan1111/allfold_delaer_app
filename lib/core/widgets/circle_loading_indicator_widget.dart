import 'package:flutter/material.dart';
import 'package:sales_app/core/constants/app_colors.dart';

class CircleLoadingIndicatorWidget extends StatelessWidget {
  const CircleLoadingIndicatorWidget({
    super.key,
    this.height,
    this.width,
    this.heightDimBg,
    this.widthDimBg,
    this.isDimBg = true,
  });

  final double? height;
  final double? width;
  final double? heightDimBg;
  final double? widthDimBg;
  final bool isDimBg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: isDimBg ? double.infinity : (height ?? 30),
        width: isDimBg ? double.infinity : (width ?? 30),
        color: Colors.transparent,
        child: Center(
          child: Container(
            width: isDimBg ? (widthDimBg ?? 80) : (width ?? 30),
            height: isDimBg ? (heightDimBg ?? 80) : (height ?? 30),
            decoration: BoxDecoration(
                color: isDimBg ? Colors.black26 : Colors.transparent,
                borderRadius: BorderRadius.circular(8.0)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: width ?? 30,
                  height: height ?? 30,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorPrimary),
                    strokeWidth: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
