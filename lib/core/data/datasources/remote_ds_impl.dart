import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:sales_app/core/constants/api_constants.dart';
import 'package:sales_app/core/data/datasources/i_remote_ds.dart';
import 'package:sales_app/core/dependency/global_get_it.dart';
import 'package:sales_app/core/error/error_codes.dart';
import 'package:sales_app/core/error/failure.dart';
import 'package:sales_app/core/model/i_response.dart';
import 'package:sales_app/core/model/response_model.dart';
import 'package:sales_app/core/network/refresh_token_interceptor.dart';
import 'package:sales_app/core/storage/i_preference.dart';
import 'package:sales_app/core/storage/preference_keys.dart';
import 'package:sales_app/core/utils/network_info.dart';

Map<String, String> commonHeader = {
  'Content-Type': 'application/json',
  'Accept': '*/*',
};

void printWrappedLog(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

class RemoteDataSourceImpl extends IRemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<IResponse> executeGet({
    required String path,
    NetworkInfo? networkInfo,
    String? query,
    Map<String, String>? qParams,
    String? queryValue,
    String? token,
    Map<String, dynamic>? requestBody,
  }) async {
    bool isConnected = await globalGetIt<NetworkInfo>().isConnected;
    http.Response? response;
    if (isConnected) {
      try {
        if (kDebugMode) {
          printWrappedLog('api request header :: ${commonHeader.toString()}');
          printWrappedLog('api request url :: ${ApiConstants.baseUrl}$path');
          printWrappedLog('api request body :: ${requestBody.toString()}');
        }

        ResponseModel responseData;
        // client = InterceptedClient.build(interceptors: [RefreshTokenInterceptor()]);
        qParams != null
            ? response = await client.get(
                Uri.http(ApiConstants.baseUrl, path, qParams),
              )
            : response = await client.get(
                Uri.http(ApiConstants.baseUrl, path,
                    query != null ? {query: queryValue} : null),
              );
        if (kDebugMode) {
          printWrappedLog('executeGet :: ${response.request?.url ?? ''}');
          printWrappedLog('executeGet :: ${response.body}');
        }

        responseData = ResponseModel.fromJson(json.decode(response.body));
        if (response.statusCode == 200) {
          return responseData;
        } else {
          throw ServerFailure(
            statusFailCode: response.statusCode,
            statusMessage: response.reasonPhrase.toString(),
            errorFailMessage: responseData.message ?? '',
          );
        }
      } on FormatException {
        throw ServerFailure(
          statusFailCode: response?.statusCode,
          statusMessage: response?.reasonPhrase.toString(),
          errorFailMessage:
              "${response?.statusCode} ${response?.reasonPhrase.toString()}",
        );
      } on Exception catch (error) {
        if (kDebugMode) {
          print("exception error get : $error");
        }
        throw AppFailure(
          errorMessages: error.toString(),
          statusCodes: ErrorCodes.errorAtDatasource,
        );
      }
    } else {
      throw ErrorMessages.errorDeviceOffline;
    }
  }

  @override
  Future<IResponse> executePost({
    required String path,
    NetworkInfo? networkInfo,
    String? query,
    String? queryValue,
    String? token,
    Map<String, String>? qParams,
    Object? requestBody,
  }) async {
    bool isConnected = await globalGetIt<NetworkInfo>().isConnected;
    http.Response? response;

    if (isConnected) {
      try {
        ResponseModel? responseData;
        if (kDebugMode) {
          printWrappedLog('api request header :: ${commonHeader.toString()}');
          printWrappedLog('api request url :: ${ApiConstants.baseUrl}$path');
          printWrappedLog('api request body :: ${requestBody.toString()}');
        }
        // http.Client clientIntercept = client;
        // clientIntercept = InterceptedClient.build(
        //   interceptors: [RefreshTokenInterceptor(client: client)],
        //   retryPolicy: InterceptorRetryPolicy(client: client),
        // );

        /*qParams != null
            ? response = await clientIntercept.post(
                Uri.http(
                  ApiConstants.baseUrl,
                  path,
                  qParams,
                ),
                headers: commonHeader,
                body: requestBody,
              )
            : */
        String token = await globalGetIt<IPreference>().getPreferenceValue(
            preferenceKey: PreferenceKey.token, defaultValue: '');
        Map<String, dynamic> reqMap = json.decode(requestBody.toString());
        reqMap.addAll({'token': token});

        response = await client.post(
          Uri.http(ApiConstants.baseUrl, path,
              query != null ? {query: queryValue} : null),
          headers: commonHeader,
          // body: requestBody,
          body: jsonEncode(reqMap),
        );
        responseData = ResponseModel.fromJson(json.decode(response.body));
        if (kDebugMode) {
          printWrappedLog('executePost :: ${response.request?.url ?? ''}');
          printWrappedLog('executePost :: ${response.body}');
          printWrappedLog('executePost response body :: ${response.body}');
        }

        if (response.statusCode == 200) {
          return responseData;
        } else {
          throw ServerFailure(
            statusFailCode: response.statusCode,
            statusMessage: response.reasonPhrase.toString(),
            errorFailMessage: responseData.message ?? '',
          );
        }
      } on FormatException catch (error) {
        if (kDebugMode) {
          print("error in remote :: $error");
        }
        throw ServerFailure(
          statusFailCode: response?.statusCode,
          statusMessage: response?.reasonPhrase.toString(),
          errorFailMessage:
              "${response?.statusCode} ${response?.reasonPhrase.toString()}",
        );
      } on Exception catch (error) {
        if (kDebugMode) {
          print("logcat :: error in remote : $error");
        }
        throw AppFailure(
          errorMessages: error.toString(),
          statusCodes: ErrorCodes.errorAtDatasource,
        );
      }
    } else {
      throw ErrorMessages.errorDeviceOffline;
    }
  }
}
