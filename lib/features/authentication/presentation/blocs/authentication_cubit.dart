import 'dart:collection';

import 'package:auto_route/auto_route.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/routes/app_router.gr.dart';
import 'package:sales_app/core/storage/i_preference.dart';
import 'package:sales_app/core/storage/preference_keys.dart';
import 'package:sales_app/core/widgets/common_functions.dart';
import 'package:sales_app/features/authentication/data/models/login_response.dart';
import 'package:sales_app/features/authentication/domain/usecase/authentication_usecase.dart';
import 'package:sales_app/features/authentication/domain/usecase/forgot_password_usecase.dart';

import 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required this.iPreference,
    required this.authenticationUseCase,
    required this.forgotPasswordUseCase,
  }) : super(AuthenticationState().init());

  IPreference iPreference;
  AuthenticationUseCase authenticationUseCase;
  ForgotPasswordUseCase forgotPasswordUseCase;

  TextEditingController emailEditController = TextEditingController();
  TextEditingController passwordEditController = TextEditingController();

  LoginResponse? loginResponse;

  String? fcmToken;

  Future<void> getFcmTokenFromFirebase() async {
    // await FirebaseMessaging.instance.getToken().then((value) async {
    //   fcmToken = value;
    // });
  }

  bool validateFields() {
    if (emailEditController.text.isEmpty) {
      showToastMsg('Please enter your email');
      return false;
    } else if (!AppConstants.emailRegex
        .hasMatch(emailEditController.text.toString().trim())) {
      showToastMsg('Please enter valid email');
      return false;
    } else if (passwordEditController.text.isEmpty) {
      showToastMsg('Please enter your password');
      return false;
    }
    return true;
  }

  bool validateFieldForgotPassword() {
    if (emailEditController.text.isEmpty) {
      showToastMsg('Please enter your email');
      return false;
    } else if (!AppConstants.emailRegex
        .hasMatch(emailEditController.text.toString().trim())) {
      showToastMsg('Please enter valid email');
      return false;
    }
    return true;
  }

  void apiCallLogin(BuildContext context) async {
    if (validateFields() == false) return;
    emit(LoadingState());
    final res = await authenticationUseCase(HashMap.from({
      'login': emailEditController.text.trim().toString(),
      'password': passwordEditController.text.trim(),
    }));

    if (kDebugMode) {
      print('logcat :: api response login = ${res.toString()}');
    }

    res.fold((l) {
      showToastMsg(l.errorMessage);
      emit(FailureState());
      return l;
    }, (r) {
      loginResponse = r;
      iPreference.setPreferenceValue(
          preferenceKey: PreferenceKey.token, value: r.data?.token);
      iPreference.setPreferenceValue(
          preferenceKey: PreferenceKey.userId, value: r.data?.id);
      iPreference.setPreferenceValue(
          preferenceKey: PreferenceKey.disCode, value: r.data?.discode);
      emit(SuccessState());
      AutoRouter.of(context).replaceAll([const DashboardRoute()]);
      return r;
    });
  }

  void apiCallForgotPassword(BuildContext context) async {
    if (validateFieldForgotPassword() == false) return;
    emit(LoadingState());
    final res = await forgotPasswordUseCase(HashMap.from({
      'email': emailEditController.text.trim().toString(), // Todo static check param of this api
    }));

    if (kDebugMode) {
      print('logcat :: api response login = ${res.toString()} ');
    }

    res.fold((l) {
      showToastMsg(l.errorMessage);
      emit(FailureState());
      return l;
    }, (r) {
      loginResponse = r;
      AutoRouter.of(context).maybePop();
      emit(SuccessState());
      return r;
    });
  }
}
