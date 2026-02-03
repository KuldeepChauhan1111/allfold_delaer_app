class LoginModel {
  Data? data;
  bool? isSuccessful;
  int? code;
  String? message;

  LoginModel({this.data, this.isSuccessful, this.code, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
    isSuccessful = json['IsSuccessful'];
    code = json['Code'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    data['IsSuccessful'] = this.isSuccessful;
    data['Code'] = this.code;
    data['Message'] = this.message;
    return data;
  }
}

class Data {
  int? userId;
  String? email;
  String? phoneNumber;
  String? password;
  int? userTypeId;
  String? userType;
  String? token;

  Data(
      {this.userId,
        this.email,
        this.phoneNumber,
        this.password,
        this.userTypeId,
        this.userType,
        this.token});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    email = json['Email'];
    phoneNumber = json['PhoneNumber'];
    password = json['Password'];
    userTypeId = json['UserTypeId'];
    userType = json['UserType'];
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['Email'] = this.email;
    data['PhoneNumber'] = this.phoneNumber;
    data['Password'] = this.password;
    data['UserTypeId'] = this.userTypeId;
    data['UserType'] = this.userType;
    data['Token'] = this.token;
    return data;
  }
}
