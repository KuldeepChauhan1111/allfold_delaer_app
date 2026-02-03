import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_app/core/storage/i_preference.dart';
import 'package:sales_app/core/storage/preference_keys.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/core/widgets/common_functions.dart';
import 'package:sales_app/features/category/data/models/get_categories_response.dart';
import 'package:sales_app/features/category/domain/usecase/get_categories_usecase.dart';
import 'package:sales_app/features/category/presentation/blocs/categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({
    required this.iPreference,
    required this.getCategoriesUseCase,
  }) : super(CategoriesState().init());

  IPreference iPreference;
  GetCategoriesUseCase getCategoriesUseCase;

  List<Categories> categoryList = [];

  String? token;

  Future<void> _getPrefUserToken() async {
    token = await iPreference.getPreferenceValue(
        preferenceKey: PreferenceKey.token, defaultValue: '');
  }

  void apiCallGetCategories(BuildContext context) async {
    await _getPrefUserToken();
    emit(LoadingState());
    final res = await getCategoriesUseCase(HashMap.from({
      'token': token,
    }));

    if (kDebugMode) {
      print('logcat :: api response login = ${res.toString()} ');
    }

    res.fold((l) {
      if (l.isUnauthorizedUser) {
        iPreference.clearPreference();
        AppUtils.redirectToLogin(context: context);
      } else {
        showToastMsg(l.errorMessage);
      }
      emit(FailureState());
      return l;
    }, (r) {
      categoryList = r.data?.categories ?? [];
      categoryList.add(Categories(categoryId: 2,category: "Cloth Stand",));
      emit(SuccessState());
      return r;
    });
  }
}
