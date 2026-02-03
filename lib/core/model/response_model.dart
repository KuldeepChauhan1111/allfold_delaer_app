import 'package:json_annotation/json_annotation.dart';
import 'package:sales_app/core/model/i_response.dart';

part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel implements IResponse {
  final String? isError;
  final String? errorCode;
  final String? isValidationFailed;
  final int? code;
  final String? message;
  final dynamic data;

  ResponseModel({
    this.data,
    this.isError,
    this.errorCode,
    this.isValidationFailed,
    this.code,
    this.message,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}
