class LoginResponse {
  LoginResponse({
    this.isError,
    this.isValidationFailed,
    this.errorCode,
    this.message,
    this.data,
  });

  LoginResponse.fromJson(dynamic json) {
    isError = json['isError'];
    isValidationFailed = json['isValidationFailed'];
    errorCode = json['errorCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? isError;
  String? isValidationFailed;
  String? errorCode;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isError'] = isError;
    map['isValidationFailed'] = isValidationFailed;
    map['errorCode'] = errorCode;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.user,
    this.token,
    this.id,
    this.login,
    this.name,
    this.discode,
  });

  Data.fromJson(dynamic json) {
    user = json['user'];
    token = json['token'];
    id = json['id'];
    login = json['login'];
    name = json['name'];
    discode = json['discode'];
  }

  String? user;
  String? token;
  int? id;
  String? login;
  String? name;
  String? discode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = user;
    map['token'] = token;
    map['id'] = id;
    map['login'] = login;
    map['name'] = name;
    map['discode'] = discode;
    return map;
  }
}
