import 'dart:convert';

import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/constants/app_size_constants.dart';
import 'package:sales_app/core/utils/image_path.dart';
import 'package:sales_app/core/widgets/circle_loading_indicator_widget.dart';

extension AppExtensions on String {
  Widget textWidget({
    double fontSize = fontSizeNormal,
    FontWeight fontWeight = FontWeight.normal,
    TextOverflow? overflow,
    int? maxLine,
    TextAlign? textAlign,
    Color color = AppColors.colorWhite,
    String? fontFamily,
    FontStyle? fonStyle,
    double? height,
    double? latterSpacing,
  }) =>
      Text(
        this,
        overflow: overflow,
        maxLines: maxLine,
        textAlign: textAlign,
        style: TextStyle(
            fontSize: fontSize,
            color: color,
            fontWeight: fontWeight,
            fontStyle: fonStyle,
            height: height ?? 1.3,
            letterSpacing:
                (fontFamily == AppConstants.fontFamilyTeko) ? 1 : latterSpacing,
            fontFamily: fontFamily ?? AppConstants.fontFamilyPoppins),
      );

  Widget htmlTextView({
    double fontSize = fontSizeNormal,
    FontWeight fontWeight = FontWeight.normal,
    TextOverflow? overflow,
    int? maxLine,
    TextAlign? textAlign,
    Color color = AppColors.colorBlack,
    String? fontFamily,
    double? height,
    double? latterSpacing,
  }) =>
      HtmlWidget(
        this,

        textStyle: TextStyle(

            fontSize: fontSize,
            color: color,
            fontWeight: fontWeight,
            height: height ?? 1.3,
            overflow: overflow,


            letterSpacing:
                (fontFamily == AppConstants.fontFamilyTeko) ? 1 : latterSpacing,
            fontFamily: fontFamily ?? AppConstants.fontFamilyRoboto),
      );

  Widget richTextView({
    double fontSize = fontSizeNormal,
    FontWeight fontWeight = FontWeight.normal,
    TextOverflow? overflow,
    int? maxLine,
    TextAlign? textAlign,
    Color color = AppColors.colorWhite,
    String? fontFamily,
    double? height,
    List<InlineSpan>? textSpanList,
  }) =>
      RichText(
          text: TextSpan(
        text: this,
        style: TextStyle(
            fontSize: fontSize,
            color: color,
            fontWeight: fontWeight,
            height: height ?? 1.4,
            fontFamily: fontFamily ?? AppConstants.fontFamilyPoppins),
        children: textSpanList ?? [],
      ));

  Widget imageAssetWidget({
    double? height,
    double? width,
    double? padding,
    BoxFit? boxFit,
    Color? iconColor,
  }) =>
      Container(
        padding: EdgeInsets.all(padding ?? 0),
        child: Image.asset(
          this,
          height: height ?? 24,
          width: width ?? 24,
          fit: boxFit ?? BoxFit.contain,
          color: iconColor,
        ),
      );

  Widget toNetWorkImage({
    double height = 50,
    double width = 50,
    num borderRadius = 20,
    bool isAllRounded = true,
    double topLeftBorder = 10.0,
    double topRightBorder = 10.0,
    double bottomLeftBorder = 10.0,
    double bottomRightBorder = 10.0,
    BoxFit fit = BoxFit.cover,
    String? placeHolderAssets,
    VoidCallback? onTap,
    double? errorPaddingAll,
  }) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: this,
            height: height,
            width: width,
            fit: fit,
            imageBuilder: (context, imageProvider) => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: isAllRounded
                    ? BorderRadius.circular(borderRadius.toDouble())
                    : BorderRadius.only(
                        bottomLeft: Radius.circular(bottomLeftBorder),
                        bottomRight: Radius.circular(bottomRightBorder),
                        topLeft: Radius.circular(topLeftBorder),
                        topRight: Radius.circular(topRightBorder),
                      ),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
                decoration: BoxDecoration(
                  borderRadius: isAllRounded
                      ? BorderRadius.circular(borderRadius.toDouble())
                      : BorderRadius.only(
                          bottomLeft: Radius.circular(bottomLeftBorder),
                          bottomRight: Radius.circular(bottomRightBorder),
                          topLeft: Radius.circular(topLeftBorder),
                          topRight: Radius.circular(topRightBorder),
                        ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(errorPaddingAll ?? 5.0),
                  child:
                      (placeHolderAssets ?? icPlaceholder).imageAssetWidget(),
                )),
            progressIndicatorBuilder: (_, __, ___) =>
                const CircleLoadingIndicatorWidget(),
          ),
        ],
      );

  Widget imageBase64({
    double? height,
    double? width,
    BoxFit? fit,
  }) =>
      (isEmpty)
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: (icPlaceholder)
                  .imageAssetWidget(height: height, width: width,iconColor: AppColors.colorLightGrey,boxFit: BoxFit.contain),
            )
          : /*Image.memory(
              height: height,
              width: width,
              const Base64Decoder().convert(this),
              fit: fit,
            )*/
          CachedMemoryImage(
              uniqueKey: this,
              height: height,
              width: width,
              fit: fit ?? BoxFit.contain,
              errorWidget: (icPlaceholder)
                  .imageAssetWidget(height: height, width: width),
              bytes: const Base64Decoder().convert(this),
            );

  Widget dateView({required Function callBack}) {
    return GestureDetector(
      onTap: () {
        callBack();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.colorPrimary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.calendar_month_rounded,
              color: AppColors.colorWhite,
              size: 20,
            ),
            8.toSizedBoxWidth,
            (this).textWidget(color: AppColors.colorWhite),
          ],
        ),
      ),
    );
  }
}

extension AppWidgetExtension on Widget {
  Widget toVisibility(bool value) => Visibility(
        visible: value,
        child: this,
      );
}

extension AppIntExtension on num {
  SizedBox get toSizedBox => SizedBox(height: toDouble(), width: toDouble());

  SizedBox get toSizedBoxHeight => SizedBox(height: toDouble());

  SizedBox get toSizedBoxWidth => SizedBox(width: toDouble());

  EdgeInsets get paddingHorizontal =>
      EdgeInsets.symmetric(horizontal: toDouble());

  EdgeInsets get paddingVertical => EdgeInsets.symmetric(vertical: toDouble());

  EdgeInsets get paddingAll => EdgeInsets.all(toDouble());
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}