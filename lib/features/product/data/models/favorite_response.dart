class FavoriteResponse {
  FavoriteResponse({
    this.isError,
    this.isValidationFailed,
    this.errorCode,
    this.status,
    this.data,
  });

  FavoriteResponse.fromJson(dynamic json) {
    isError = json['isError'];
    isValidationFailed = json['isValidationFailed'];
    errorCode = json['errorCode'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? isError;
  String? isValidationFailed;
  String? errorCode;
  String? status;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isError'] = isError;
    map['isValidationFailed'] = isValidationFailed;
    map['errorCode'] = errorCode;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.product,
  });

  Data.fromJson(dynamic json) {
    product = json['product'];
  }

  String? product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product'] = product;
    return map;
  }
}
