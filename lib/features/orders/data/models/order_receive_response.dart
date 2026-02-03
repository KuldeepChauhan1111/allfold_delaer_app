class OrderReceiveResponse {
  OrderReceiveResponse({
    this.isError,
    this.isValidationFailed,
    this.errorCode,
    this.status,
    this.message,
  });

  OrderReceiveResponse.fromJson(dynamic json) {
    isError = json['isError'];
    isValidationFailed = json['isValidationFailed'];
    errorCode = json['errorCode'];
    status = json['status'];
    message = json['message'];
  }

  String? isError;
  String? isValidationFailed;
  String? errorCode;
  String? status;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isError'] = isError;
    map['isValidationFailed'] = isValidationFailed;
    map['errorCode'] = errorCode;
    map['status'] = status;
    map['message'] = message;
    return map;
  }
}
