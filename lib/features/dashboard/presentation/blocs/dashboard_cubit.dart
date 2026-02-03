import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_app/core/storage/i_preference.dart';
import 'package:sales_app/core/widgets/common_functions.dart';
import 'package:sales_app/features/authentication/domain/usecase/authentication_usecase.dart';
import 'package:sales_app/features/dashboard/presentation/blocs/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({
    required this.iPreference,
    required this.authenticationUseCase,
  }) : super(DashboardState().init());

  AuthenticationUseCase authenticationUseCase;

  IPreference iPreference;

  void apiCallGetCategories(BuildContext context) async {
    emit(LoadingState());
    final res = await authenticationUseCase(HashMap.from({
      'login': '',
      'password': '',
    }));

    if (kDebugMode) {
      print('logcat :: api response cubit = ${res.toString()} ');
    }

    res.fold((l) {
      showToastMsg(l.errorMessage);
      emit(FailureState());
      return l;
    }, (r) {
      emit(SuccessState());
      return r;
    });
  }
}
