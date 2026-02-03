import 'package:flutter/material.dart';
import 'package:sales_app/core/constants/app_colors.dart';

class CommonBoxTextField extends StatelessWidget {
  String? labelText;
  double? allBorderRadius;
  double? labelFontSize;
  double? hintFontSize;
  double? inputTextFontSize;
  double? topContentPadding;
  double? bottomContentPadding;
  int? maxLength;
  int? maxLines;
  Color? labelTextColor;
  Color? hintTextColor;
  Color? focusedBorderColor;
  Color? enabledBorderColor;
  Color? cursorColor;
  Color? inputTextColor;
  TextInputType? textInputType;
  String? fontFamily;
  String? labelFontFamily;
  String? hintFontFamily;
  TextEditingController? controller;
  Function(String)? onChanged;
  String? hintText;
  double? letterSpacing;
  TextInputAction? textInputAction;

  CommonBoxTextField(
      {Key? key,
        this.labelText,
        this.allBorderRadius,
        this.focusedBorderColor,
        this.enabledBorderColor,
        this.inputTextFontSize,
        this.labelFontFamily,
        this.textInputType,
        this.controller,
        this.hintText,
        this.cursorColor,
        this.inputTextColor,
        this.maxLength,
        this.fontFamily,
        this.onChanged,
        this.hintFontFamily,
        this.maxLines,
        this.hintFontSize,
        this.topContentPadding,
        this.bottomContentPadding,
        this.letterSpacing,
        this.hintTextColor,
        this.labelFontSize,
        this.textInputAction,
        this.labelTextColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextField(
      maxLines: maxLines,
      maxLength: maxLength,
      onChanged: onChanged,
      controller: controller,
      style: TextStyle(
        letterSpacing: letterSpacing,
        color: inputTextColor ?? AppColors.colorSecondary,
        fontSize: inputTextFontSize ?? 16,
        fontFamily:fontFamily,
      ),
      keyboardType: textInputType ?? TextInputType.text,
      textInputAction: textInputAction ?? TextInputAction.next,
      cursorColor:  cursorColor ?? AppColors.colorPrimary,
      decoration: InputDecoration(
        counterText: "",
        contentPadding: EdgeInsets.only(left: 10,right: 10,top: topContentPadding ?? 0,bottom: bottomContentPadding ?? 0),
        alignLabelWithHint: true,
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(color: hintTextColor ?? AppColors.colorText, fontSize: hintFontSize ?? 14,fontFamily: hintFontFamily),
        labelStyle: TextStyle(color: labelTextColor ?? AppColors.colorText, fontSize: labelFontSize ?? 14,fontFamily: labelFontFamily),
        filled: true,
        fillColor: Colors.transparent,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(allBorderRadius ?? 12)),
          borderSide: BorderSide(width: 1.5, color: focusedBorderColor ?? AppColors.colorSecondary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(allBorderRadius  ?? 12)),
          borderSide: BorderSide(width: 01, color: enabledBorderColor ?? AppColors.colorSecondary),
        ),
      ),
    );
  }
}
