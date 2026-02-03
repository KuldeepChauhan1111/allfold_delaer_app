import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_app/core/storage/i_preference.dart';
import 'package:sales_app/core/storage/preference_keys.dart';
import 'package:sales_app/core/widgets/common_functions.dart';
import 'package:sales_app/features/cart/data/models/checkout_req_model.dart';
import 'package:sales_app/features/cart/domain/usecase/checkout_usecase.dart';
import 'package:sales_app/features/cart/presentation/blocs/cart_state.dart';
import 'package:sales_app/features/product/data/models/product_details_response.dart';
import 'package:sales_app/features/product/presentation/blocs/product_cubit.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required this.iPreference,
    required this.checkoutUsecase,
  }) : super(CartState().init());

  IPreference iPreference;
  CheckoutUsecase checkoutUsecase;

  String? token;

  Future<void> _getPrefUserToken() async {
    token = await iPreference.getPreferenceValue(
        preferenceKey: PreferenceKey.token, defaultValue: '');
  }

  Future<String> _prepareCheckoutRequestString() async {
    List<ProductInfo> list = await getCartProductListFromPreference();
    List<CheckoutReqModel> reqList = [];
    for (int i = 0; i < list.length; i++) {
      reqList.add(CheckoutReqModel(
          productid: list[i].productVariantId, quantity: list[i].qty));
    }
    return convertJsonToString(reqList);
  }

  void apiCallCheckout() async {
    await _getPrefUserToken();
    emit(LoadingState());

    String reqLineData = await _prepareCheckoutRequestString();
    final res = await checkoutUsecase(HashMap.from({
      'token': token,
      'linedatas': reqLineData,
    }));

    if (kDebugMode) {
      print('logcat :: api response = ${res.toString()} ');
    }

    res.fold((l) {
      showToastMsg(l.errorMessage);
      emit(FailureState());
      return l;
    }, (r) async {
      await iPreference.clearPreferenceKey(key: PreferenceKey.cartListPref);
      await iPreference.clearPreferenceKey(key: PreferenceKey.cartItemCountPref);
      emit(SuccessStateCheckout());
      return r;
    });
  }
}
