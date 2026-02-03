import 'package:action_slider/action_slider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:intl/intl.dart';
import 'package:sales_app/core/common_stateful_widgets/common_dialog.dart';
import 'package:sales_app/core/common_stateful_widgets/common_two_btn_dialog.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/constants/app_strings_constants.dart';
import 'package:sales_app/core/routes/app_router.gr.dart';
import 'package:sales_app/core/utils/app_extensions.dart';
import 'package:sales_app/core/utils/image_path.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  void hideKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static void redirectToLogin({required BuildContext context}) {
    AutoRouter.of(context).replaceAll([const LogInRoute()]);
  }

  static Future<void> launchToBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  static String getDate({required String date, required String format}) {
    print("uuuuuuuuu $date");
    String parseDate = '';
    if (date != '') {
      try {
        parseDate = DateFormat(format).format(DateTime.parse(date));
      } catch (e) {
        return parseDate;
      }
    }
    return parseDate;
  }

  static fourDotWidget({VoidCallback? onTap}) {
    return commonInkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap ?? () {},
      child: AppUtils.commonContainer(
          child: AppUtils.commonContainer(
            padding: AppUtils.edgeInsetsAll(allPadding: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    AppUtils.commonContainer(
                        height: 5,
                        width: 5,
                        decoration: AppUtils.commonBoxDecoration(
                            color: AppColors.colorLightGrey,
                            shape: BoxShape.circle)),
                    AppUtils.commonSizedBox(width: 10),
                    AppUtils.commonContainer(
                        height: 5,
                        width: 5,
                        decoration: AppUtils.commonBoxDecoration(
                            color: AppColors.colorLightGrey,
                            shape: BoxShape.circle)),
                  ],
                ),
                AppUtils.commonSizedBox(height: 10),
                Row(
                  children: [
                    AppUtils.commonContainer(
                        height: 5,
                        width: 5,
                        decoration: AppUtils.commonBoxDecoration(
                            color: AppColors.colorLightGrey,
                            shape: BoxShape.circle)),
                    AppUtils.commonSizedBox(width: 10),
                    AppUtils.commonContainer(
                        height: 5,
                        width: 5,
                        decoration: AppUtils.commonBoxDecoration(
                            color: AppColors.colorLightGrey,
                            shape: BoxShape.circle)),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  static Widget appLogoDummy(
      {double? logoSize, Color? primaryTextColor, Color? secondaryTextColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        commonTextWidget(
            text: "SALES",
            textAlign: TextAlign.center,
            fontSize: logoSize ?? AppConstants.thirtyFive,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            textColor: primaryTextColor ?? AppColors.colorDarkGrey,
            fontFamily: AppConstants.fontFamilyTeko),
        commonTextWidget(
            text: "APP",
            textAlign: TextAlign.center,
            fontSize: logoSize ?? AppConstants.thirtyFive,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            textColor: secondaryTextColor ?? AppColors.colorMainBlack,
            fontFamily: AppConstants.fontFamilyTeko),
      ],
    );
  }

  static Widget commonTextWidget({
    required String text,
    Color? textColor,
    double? fontSize,
    double? letterSpacing,
    FontWeight? fontWeight,
    double? height,
    String? fontFamily,
    TextAlign? textAlign,
    EdgeInsets? margin,
    EdgeInsets? padding,
    TextDecoration? decoration,
    bool? softWrap,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return commonContainer(
      padding: padding,
      margin: margin,
      child: Text(
        softWrap: softWrap,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        text,
        style: TextStyle(
          decoration: decoration,
          color: textColor ?? AppColors.colorWhite,
          fontSize: fontSize ?? AppConstants.fourteen,
          letterSpacing: letterSpacing ?? AppConstants.two,
          fontWeight: fontWeight,
          height: height,
          fontFamily: fontFamily ?? AppConstants.fontFamilyRoboto,
        ),
      ),
    );
  }

  static Widget noDataWidget({String? msg}) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            icNoData,
            fit: BoxFit.cover,
            height: 150,
            // width: 80,
          ),
          AppUtils.commonTextWidget(
              margin: edgeInsetsOnly(top: 5),
              text: msg ?? msgNoData,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              textColor: AppColors.colorWhite),
          60.toSizedBoxHeight
        ],
      ),
    );
  }

  static Widget emptyCartWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            icEmptyCart,
            fit: BoxFit.cover,
            height: 200,
            // width: 80,
          ),
          AppUtils.commonTextWidget(
            margin: edgeInsetsOnly(top: 5),
            text: "Your Cart is Empty",
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            textColor: AppColors.colorLightGrey,
          ),
          AppUtils.commonTextWidget(
            margin: edgeInsetsOnly(top: 5),
            text: "Add something to make me happy :)",
            fontSize: 12,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.5,
            textColor: AppColors.colorLightGrey,
          ),
        ],
      ),
    );
  }

  static Widget commonSizedBox({
    double? height,
    double? width,
    Widget? child,
  }) {
    return SizedBox(
      height: height,
      width: width,
      child: child,
    );
  }

  static showCustomDialog({required BuildContext ctx,
    String? dialogMessage,
    String? dialogBtnText,
    String? dialogTitle}) {
    showDialog(
      context: ctx,
      builder: (context) {
        return CommonDialog(
          dialogMessage: dialogMessage,
          dialogBtnText: dialogBtnText,
          dialogTitle: dialogTitle,
        );
      },
    );
  }

  static showCustomTwoBtnDialog({required BuildContext ctx,
    String? dialogMessage,
    String? dialogBtnTextRight,
    String? dialogBtnTextLeft,
    bool? leftPop,
    bool? rightPop,
    VoidCallback? dialogBtnLeftFnc,
    VoidCallback? dialogBtnRightFnc,
    String? dialogTitle}) {
    showDialog(
      context: ctx,
      builder: (context) {
        return CommonTwoBtnDialog(
          dialogMessage: dialogMessage,
          dialogBtnTextRight: dialogBtnTextRight,
          dialogBtnTextLeft: dialogBtnTextLeft,
          dialogTitle: dialogTitle,
          dialogBtnLeftFnc: dialogBtnLeftFnc,
          dialogBtnRightFnc: dialogBtnRightFnc,
          leftPop: leftPop,
          rightPop: rightPop,
        );
      },
    );
  }

  static EdgeInsets edgeInsetsOnly({
    double? bottom,
    double? top,
    double? right,
    double? left,
  }) {
    return EdgeInsets.only(
        bottom: bottom ?? AppConstants.zero,
        top: top ?? AppConstants.zero,
        right: right ?? AppConstants.zero,
        left: left ?? AppConstants.zero);
  }

  static EdgeInsets edgeInsetsAll({
    double? allPadding,
  }) {
    return EdgeInsets.all(allPadding ?? 0);
  }

  static double getMediaHeight(BuildContext uiContext) {
    return MediaQuery
        .of(uiContext)
        .size
        .height;
  }

  static double getMediaWidth(BuildContext uiContext) {
    return MediaQuery
        .of(uiContext)
        .size
        .width;
  }

  static Widget commonContainer({
    double? height,
    double? width,
    BoxDecoration? decoration,
    EdgeInsets? margin,
    EdgeInsets? padding,
    Widget? child,
    Color? color,
    BoxConstraints? constraints,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: decoration,
      margin: margin,
      constraints: constraints,
      padding: padding,
      color: color,
      child: child,
    );
  }


  static BoxDecoration commonGradientBoxDecoration(
      {double? borderRadius, Color? gradient1, Color? gradient2,Color? border,BoxShape? shape,double? borderWidth}) {
    return BoxDecoration(shape: shape ?? BoxShape.rectangle,
      // color: AppColors.colorTransparent,
      gradient: LinearGradient(
        colors: [gradient1 ?? AppColors.gradient1, gradient2 ?? AppColors.gradient2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(borderRadius ?? 12),
      border: Border.all(color: border ?? Colors.transparent, width: borderWidth?? 1.5),
    );
  }

  static Widget commonGlassmorphicContainer
      ({
    double width = double.infinity,
    double height = 70,
    double borderRadius = 20,
    double blur = 60,
    Alignment alignment = Alignment.center,
    double border = 0,
    final EdgeInsets? padding,
    final EdgeInsets? margin,
    required Widget child,
  }) {
    return GlassmorphicContainer(
      padding: padding,
      margin: margin,

      width: width,
      height: height,
      borderRadius: borderRadius,
      blur: blur,
      alignment: alignment,
      border: border,
      linearGradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.white.withOpacity(0.15),
          Colors.white.withOpacity(0.15),
        ],
        stops: const [0.1, 1],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.white.withOpacity(0.0),
          Colors.white.withOpacity(0.0),
        ],
      ),
      child: child,
    );
  }


  static Widget slideButton({required Function onSwipe, String? text, required BuildContext context}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 16.0),
      child:ActionSlider.standard(
        action: (controller) {

          if(onSwipe != null){
            onSwipe();
          }
          // AppUtils.showCustomTwoBtnDialog(
          //   ctx: context,
          //   dialogTitle: "Accept",
          //   dialogMessage:
          //   "Are you sure do you want to change Status 'Accept' ",
          //   dialogBtnTextRight: "Accept",
          //   dialogBtnTextLeft: "Cancel",
          //   dialogBtnRightFnc: () {
          //
          //
          //     //api Call
          //   },
          // );
        },
        sliderBehavior: SliderBehavior.move,
        rolling: false,
        backgroundColor: AppColors.colorLightGrey,
        customForegroundBuilder: (p0, p1, p2) {
          return Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppColors.gradient1, AppColors.gradient2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              Icons.done,
              color: AppColors.colorWhite,
              size: 30,
            ),
          );
        },

        child: Shimmer(
          child: "$text".textWidget(
            color: AppColors.colorDarkGrey,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      )
    );
  }

  // static Widget slideButton({required Function onSwipe, String? text, required BuildContext context}){
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 16.0),
  //     child: SliderButton(
  //       vibrationFlag: true,
  //       shimmer: true,
  //       height: 70,
  //       action: () async {
  //         await onSwipe();
  //         return false;
  //       },
  //       label: Center(
  //         child:(text ??  "").textWidget(
  //           fontWeight: FontWeight.w600,
  //           fontSize: 16,
  //           textAlign: TextAlign.center,
  //         ),
  //       ),
  //       width: MediaQuery.of(context).size.width * 0.90,
  //       // radius: 360,
  //       highlightedColor: Colors.white,
  //       child: Container(
  //         width: 70,
  //         height: 70,
  //         decoration: BoxDecoration(
  //           gradient: LinearGradient(
  //             colors: [
  //               AppColors.gradient1,
  //               AppColors.gradient2,
  //             ],
  //             begin: Alignment.topLeft,
  //             end: Alignment.bottomRight,
  //           ),
  //           borderRadius: BorderRadius.circular(360),
  //         ),
  //         child: Icon(
  //           Icons.done,
  //           color: AppColors.colorLightGrey,
  //           size: 30,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  static Widget commonInkWell({
    Widget? child,
    required VoidCallback onTap,
    VoidCallback? onLongPress,
    BorderRadius? borderRadius,
    Color? highlightColor,
  }) {
    return InkWell(
      onLongPress: onLongPress,
      highlightColor: highlightColor,
      borderRadius: borderRadius,
      onTap: onTap,
      child: child,
    );
  }

  static BoxDecoration commonBoxDecoration({Color? color,
    BoxBorder? border,
    Gradient? gradient,
    BoxShape? shape,
    DecorationImage? image,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow}) {
    return BoxDecoration(
      image: image,
      shape: shape ?? BoxShape.rectangle,
      color: color,
      border: border,
      gradient: gradient,
      boxShadow: boxShadow,
      borderRadius: borderRadius,
    );
  }

  static BorderRadiusGeometry borderRadiusAll({double? raduis}) {
    return BorderRadius.all(Radius.circular(raduis ?? AppConstants.twelve));
  }

  static Widget commonElevatedBtn({
    double? width,
    Color? bgColor,
    double? borderRadiusAll,
    double? bottomMargin,
    double? topMargin,
    double? rightMargin,
    double? leftMargin,
    VoidCallback? onPressed,
    String? text,
    String? fontFamily,
    double? fontSize,
    double? letterSpacing,
    Color? textColor,
    double? height,
    BoxBorder? border,
    Gradient? gradient,
    DecorationImage? image,
    EdgeInsetsGeometry? padding,
    FontWeight? fontWeight,
  }) {
    return AppUtils.commonContainer(
      height: height,
      width: width,
      decoration: AppUtils.commonBoxDecoration(
        color: bgColor,
        gradient: gradient,
        image: image,
        border: border,
        borderRadius: BorderRadius.circular(borderRadiusAll ?? 10),
      ),
      margin: AppUtils.edgeInsetsOnly(
          bottom: bottomMargin ?? AppConstants.forty,
          top: topMargin ?? AppConstants.thirty,
          right: rightMargin ?? AppConstants.twenty,
          left: leftMargin ?? AppConstants.twenty),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: padding,
          backgroundColor: AppColors.colorTransparent,
          shadowColor: AppColors.colorTransparent,
          foregroundColor: AppColors.colorWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusAll ?? 10),
          ),
        ),
        child: AppUtils.commonTextWidget(
          text: text ?? '',
          textColor: textColor,
          fontFamily: fontFamily ?? AppConstants.fontFamilyPoppins,
          fontSize: fontSize ?? AppConstants.fourteen,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing ?? AppConstants.zero,
        ),
      ),
    );
  }

  static showSnackBarWithColor({required BuildContext context,
    required String message,
    Color? giveColor}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 1000),
        content: Text(message),
        backgroundColor: giveColor ?? AppColors.colorPrimary,
      ),
    );
  }

  static loaderWidget({Color? color, double? size}) {
    return Center(
      child: SpinKitRing(
        size: size ?? 40,
        lineWidth: 3.5,
        color: color ?? AppColors.colorPrimary,
      ),
    );
  }

  static Widget imageWidget({required String image,
    required BuildContext ctx,
    BoxFit? fit,
    double? height,
    Color? color}) {
    return Center(
      child: Image.asset(
        image,
        fit: fit ?? BoxFit.cover,
        color: color,
        height: height ?? MediaQuery
            .of(ctx)
            .size
            .height / 5,
        // height: MediaQuery.of(context).size.height,
      ),
    );
  }

  static Widget commonDiver({Color? color, double? endIndent, double? indent}) {
    return Divider(
      color: color ?? AppColors.colorGrey,
      endIndent: endIndent,
      indent: indent,
    );
  }

  static Color getStatusColor(String status) {
    Color statusColor = AppColors.colorPrimary;
    switch (status) {
      case "Pending":
        statusColor = Colors.orangeAccent;
        break;
      case "Delivered":
        statusColor = Colors.blue;
        break;
      case "Accepted":
        statusColor = Colors.green;
        break;
      default:
        statusColor = AppColors.colorPrimary;
    }
    return statusColor;
  }
}
