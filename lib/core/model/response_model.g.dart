// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel _$ResponseModelFromJson(Map<String, dynamic> json) =>
    ResponseModel(
      data: json['data'],
      isError: json['isError'] as String?,
      errorCode: json['errorCode'] as String?,
      isValidationFailed: json['isValidationFailed'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ResponseModelToJson(ResponseModel instance) =>
    <String, dynamic>{
      'isError': instance.isError,
      'errorCode': instance.errorCode,
      'isValidationFailed': instance.isValidationFailed,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
