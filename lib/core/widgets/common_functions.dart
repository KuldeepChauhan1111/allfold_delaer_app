import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/dependency/global_get_it.dart';
import 'package:sales_app/core/storage/i_preference.dart';
import 'package:sales_app/core/storage/preference_keys.dart';
import 'package:sales_app/core/utils/app_extensions.dart';
import 'package:sales_app/features/product/data/models/product_details_response.dart';

import '../utils/app_utils.dart';

void showBottomSheetDialog({
  required BuildContext context,
  required Widget widget,
  Function? onCompleteAction,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    backgroundColor: AppColors.colorWhite,
    context: context,
    builder: (context) => widget,
  ).whenComplete(() {
    if (onCompleteAction != null) {
      onCompleteAction();
    }
  });
}

void showAlertDialog({
  required BuildContext context,
  required String title,
  required Widget widget,
  bool isTitleVisible = true,
  bool isTitleCenter = false,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        backgroundColor: AppColors.colorLightGrey,
        title: isTitleVisible
            ? Row(
                mainAxisAlignment: isTitleCenter
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  title.textWidget(
                    color: AppColors.colorPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )
                ],
              )
            : const SizedBox(),
        content: widget,
      );
    },
  );
}

void showToastMsg(String msg) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(msg: msg);
}

void hideKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

String changeDateFormat(
    String oldDatePattern, String newDatePatter, String date) {
  var formattedDate =
      DateFormat(newDatePatter).format(DateFormat(oldDatePattern).parse(date));

  return formattedDate;
}

String convertJsonToString(dynamic jsonValue) {
  return jsonEncode(jsonValue);
}

Future<List<ProductInfo>> getCartProductListFromPreference() async {
  String cartListPref = await globalGetIt<IPreference>().getPreferenceValue(
      preferenceKey: PreferenceKey.cartListPref, defaultValue: '[]');

  Iterable decoded = jsonDecode(cartListPref);
  List<ProductInfo> list = decoded.map((e) => ProductInfo.fromJson(e)).toList();
  return list;
}

Future<void> saveProductInCartListPreference(
    List<ProductInfo?> prefProductInfoList) async {
  String stringList = convertJsonToString(prefProductInfoList);
  await globalGetIt<IPreference>().setPreferenceValue(
      preferenceKey: PreferenceKey.cartListPref, value: stringList);
}

Future<void> clearCartListPreference() async {
  await globalGetIt<IPreference>()
      .clearPreferenceKey(key: PreferenceKey.cartListPref);
}
