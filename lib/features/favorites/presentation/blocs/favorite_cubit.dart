import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_app/core/storage/i_preference.dart';
import 'package:sales_app/core/storage/preference_keys.dart';
import 'package:sales_app/core/widgets/common_functions.dart';
import 'package:sales_app/features/favorites/data/models/get_favorite_list_response.dart';
import 'package:sales_app/features/favorites/domain/usecase/get_favorite_list_usecase.dart';
import 'package:sales_app/features/favorites/presentation/blocs/favorite_state.dart';
import 'package:sales_app/features/product/presentation/blocs/product_cubit.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit({
    required this.iPreference,
    required this.getFavoriteListUsecase,
  }) : super(FavoriteState().init());

  IPreference iPreference;
  GetFavoriteListUsecase getFavoriteListUsecase;

  List<Products> favoriteProductList = [];

  String? token;

  Future<void> _getPrefUserToken() async {
    token = await iPreference.getPreferenceValue(
        preferenceKey: PreferenceKey.token, defaultValue: '');
  }

  void removeItemFromFavoriteList(int index) {
    favoriteProductList.removeAt(index);
    emit(FavoriteState().init());
  }

/*
  ProductVariant? getColorVariantFromList(int index) {
    return (favoriteProductList[index].productVariant ?? []).firstWhere(
        (element) =>
            (element.attributeName ?? '').toLowerCase() ==
            ProductVariantTypeEnum.colorVariant);
  }

  ProductVariant? getMaterialVariantFromList(int index) {
    return (favoriteProductList[index].productVariant ?? []).firstWhere(
        (element) =>
            (element.attributeName ?? '').toLowerCase() ==
            ProductVariantTypeEnum.materialVariant);
  }
*/

  void apiCallGetFavoriteList() async {
    await _getPrefUserToken();
    emit(LoadingState());
    final res = await getFavoriteListUsecase(HashMap.from({
      'token': token,
    }));

    if (kDebugMode) {
      print('logcat :: api response cubit = ${res.toString()} ');
    }

    res.fold((l) {
      showToastMsg(l.errorMessage);
      emit(FailureState());
      return l;
    }, (r) {
      favoriteProductList = r.data?.products ?? [];
      emit(SuccessState());
      return r;
    });
  }
}
