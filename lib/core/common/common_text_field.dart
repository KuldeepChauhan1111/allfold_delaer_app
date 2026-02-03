// import 'package:flutter/material.dart';
// import 'package:sales_app/core/constants/app_colors.dart';
//
// class CommonTextField extends StatelessWidget {
//   String? labelText;
//   double? allBorderRadius;
//   double? labelFontSize;
//   double? hintFontSize;
//   double? inputTextFontSize;
//   int? maxLength;
//   Color? labelTextColor;
//   Color? hintTextColor;
//   Color? focusedBorderColor;
//   Color? enabledBorderColor;
//   Color? cursorColor;
//   Color? inputTextColor;
//   TextInputType? textInputType;
//   String? fontFamily;
//   String? labelFontFamily;
//   TextInputAction? textInputAction;
//   String? hintFontFamily;
//   TextEditingController? controller;
//   Function(String)? onChanged;
//   String? hintText;
//   double? letterSpacing;
//   bool? obscureText;
//   Widget? suffixIcon;
//   Widget? prefixIcon;
//   int? maxLines;
//   EdgeInsetsGeometry? contentPadding;
//
//   CommonTextField(
//       {Key? key,
//       this.labelText,
//       this.allBorderRadius,
//       this.focusedBorderColor,
//       this.enabledBorderColor,
//       this.inputTextFontSize,
//       this.labelFontFamily,
//       this.textInputType,
//       this.textInputAction,
//       this.controller,
//       this.hintText,
//       this.cursorColor,
//       this.inputTextColor,
//       this.maxLength,
//       this.fontFamily,
//       this.onChanged,
//       this.hintFontFamily,
//       this.obscureText,
//       this.hintFontSize,
//       this.letterSpacing,
//       this.hintTextColor,
//       this.contentPadding,
//       this.labelFontSize,
//       this.suffixIcon,
//       this.prefixIcon,
//       this.maxLines,
//       this.labelTextColor})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       maxLines: maxLines,
//       maxLength: maxLength,
//       onChanged: onChanged,
//       obscureText: obscureText ?? false,
//       controller: controller,
//       style: TextStyle(
//         letterSpacing: letterSpacing,
//         color: inputTextColor ?? AppColors.colorMainBlack,
//         fontSize: inputTextFontSize ?? 16,
//         fontFamily: fontFamily,
//       ),
//       textInputAction: textInputAction ?? TextInputAction.done,
//       keyboardType: textInputType ?? TextInputType.text,
//       cursorColor: cursorColor ?? AppColors.colorPrimary,
//       decoration: InputDecoration(
//         prefixIcon: prefixIcon,
//         suffixIcon: suffixIcon,
//         counterText: "",
//         contentPadding:
//             contentPadding ?? const EdgeInsets.only(left: 10, right: 10),
//         alignLabelWithHint: true,
//         labelText: labelText,
//         hintText: hintText,
//         hintStyle: TextStyle(
//             color: hintTextColor ?? Colors.white.withOpacity(0.5),
//             fontSize: hintFontSize ?? 14,
//             fontFamily: hintFontFamily),
//         labelStyle: TextStyle(
//             color: labelTextColor ?? Colors.white,
//             fontSize: labelFontSize ?? 14,
//             fontFamily: labelFontFamily),
//         filled: true,
//         fillColor: Colors.transparent,
//         // focusedBorder: UnderlineInputBorder(
//         //     borderSide: BorderSide(
//         //         width: 1.5,
//         //         color: focusedBorderColor ?? AppColors.colorSecondary)),
//         // enabledBorder: UnderlineInputBorder(
//         //     borderSide: BorderSide(
//         //         width: 1.5,
//         //         color: focusedBorderColor ?? AppColors.colorSecondary)),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(allBorderRadius ?? 12)),
//           borderSide: BorderSide(width: 2, color: focusedBorderColor ?? AppColors.colorPrimary),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(allBorderRadius  ?? 12)),
//           borderSide: BorderSide(width: 1.5, color: enabledBorderColor ?? AppColors.colorPrimary),
//         ),
//       ),
//     );
//   }
// }
