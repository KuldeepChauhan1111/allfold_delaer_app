import 'package:flutter/material.dart';
import 'package:sales_app/core/constants/app_colors.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.child,
    this.cardRadius,
    this.cardShadow,
    this.cardBgColor,
    this.paddingHorizontal,
    this.paddingVertical,
    this.marginHorizontal,
    this.marginVertical,
    this.cardDefaultMargin,
  });

  final Widget child;
  final double? cardRadius;
  final double? cardShadow;
  final Color? cardBgColor;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final double? marginHorizontal;
  final double? marginVertical;
  final double? cardDefaultMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: marginHorizontal ?? 0, vertical: marginVertical ?? 0),
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal ?? 0, vertical: paddingVertical ?? 0),
      child: Card(
        margin: EdgeInsets.all(cardDefaultMargin ?? 4),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cardRadius ?? 10)),
        elevation: cardShadow ?? 3.0,
        shadowColor: Colors.grey.withOpacity(0.2),
        color: cardBgColor ?? AppColors.colorBg,
        surfaceTintColor: Colors.transparent,
        child: child,
      ),
    );
  }
}
