import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:sales_app/core/constants/api_constants.dart';
import 'package:sales_app/core/data/datasources/i_remote_ds.dart';
import 'package:sales_app/core/data/datasources/remote_ds_impl.dart';
import 'package:sales_app/core/dependency/global_get_it.dart';
import 'package:sales_app/core/model/i_response.dart';
import 'package:sales_app/core/model/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:sales_app/core/storage/i_preference.dart';
import 'package:sales_app/core/storage/preference_keys.dart';
import 'package:sales_app/features/authentication/data/models/login_response.dart';

// class RefreshTokenInterceptor extends InterceptorContract {
class RefreshTokenInterceptor extends InterceptorContract {
  final http.Client client;

  RefreshTokenInterceptor({
    required this.client,
  });

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    if (kDebugMode) {
      print('logcat :: interceptor request == ${request.toString()}');
    }
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    if (kDebugMode) {
      print('logcat :: interceptor response code = ${response.statusCode}');
      print(
          'logcat :: interceptor response path = ${response.request?.url.path}');
    }
    // final remoteDataSource = globalGetIt<IRemoteDataSource>();
    // if ((response.request?.url.path ?? '').contains(ApiConstants.login)) {
    //   return response;
    // } else {
    //   Response res = response as Response;
    //   ResponseModel responseModel =
    //       ResponseModel.fromJson(json.decode(res.body));
    //   if (responseModel.errorCode == '401') {
    //     try {
    //       IResponse responseModel = await remoteDataSource.executePost(
    //         path: ApiConstants.refreshToken,
    //         // requestBody: jsonEncode({}),
    //       );
    //       Response resModel = responseModel as Response;
    //       responseModel = await remoteDataSource.executePost(
    //         path: response.request?.url.path ?? '',
    //         // requestBody: jsonEncode({}),
    //       );
    //       // response
    //       /*client
    //         .post(Uri.http(
    //       ApiConstants.baseUrl,
    //       ApiConstants.login,
    //       HashMap.from({}),
    //     ))
    //         .then((val) {
    //       // final resModel = ResponseModel.fromJson(json.decode(val.body));
    //     });*/
    //     } catch (e) {
    //       return response;
    //     }
    //   }
    //   return response;
    // }
    return response;
  }
}

class InterceptorRetryPolicy extends RetryPolicy {
  final http.Client client;

  InterceptorRetryPolicy({
    required this.client,
  });

  @override
  int get maxRetryAttempts => 1;

  @override
  Future<bool> shouldAttemptRetryOnResponse(BaseResponse response) async {
    if ((response.request?.url.path ?? '') == ApiConstants.login ||
        (response.request?.url.path ?? '') == ApiConstants.refreshToken) {
      return false;
    } else {
      Response res = response as Response;
      ResponseModel responseModel =
          ResponseModel.fromJson(json.decode(res.body));
      String currentToken = await globalGetIt<IPreference>().getPreferenceValue(
          preferenceKey: PreferenceKey.token, defaultValue: '');
      if (responseModel.errorCode == '401') {
        final remoteDataSource = globalGetIt<IRemoteDataSource>();
        try {
          client
              .post(Uri.http(
            ApiConstants.baseUrl,
            ApiConstants.login,
            // HashMap.from({'token': currentToken}),
            HashMap.from(
                {'login': 'kenil@epistic.net', 'password': 'kenil@123'}),
          ))
              .then((val) async {
            final resModel = LoginResponse.fromJson(json.decode(val.body));
            if (kDebugMode) {
              print(
                  'logcat :: interceptor refresh token response :: ${resModel.toJson().toString()}');
            }

            await globalGetIt<IPreference>().setPreferenceValue(
                preferenceKey: PreferenceKey.token,
                value:
                    resModel.data?.token ?? ''); // TODO static save new token
          });
          return true;
        } catch (e) {
          return false;
        }
      }
    }
    return false;
  }
}
