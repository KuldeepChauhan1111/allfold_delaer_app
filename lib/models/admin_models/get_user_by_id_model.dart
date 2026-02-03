class GetUserByIdModel {
  List<Data>? data;
  bool? isSuccessful;
  int? code;
  String? message;

  GetUserByIdModel({this.data, this.isSuccessful, this.code, this.message});

  GetUserByIdModel.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    isSuccessful = json['IsSuccessful'];
    code = json['Code'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['IsSuccessful'] = this.isSuccessful;
    data['Code'] = this.code;
    data['Message'] = this.message;
    return data;
  }
}

class Data {
  int? userId;
  String? userName;
  int? userTypeId;
  String? userType;
  int? parentUserId;
  String? phoneNumber;
  String? email;
  String? password;
  String? address;
  int? countryId;
  String? countryName;
  int? stateId;
  String? stateName;
  int? cityId;
  String? cityName;
  String? profilePic;
  bool? isActive;
  String? createdOn;

  Data(
      {this.userId,
        this.userName,
        this.userTypeId,
        this.userType,
        this.parentUserId,
        this.phoneNumber,
        this.email,
        this.password,
        this.address,
        this.countryId,
        this.countryName,
        this.stateId,
        this.stateName,
        this.cityId,
        this.cityName,
        this.profilePic,
        this.isActive,
        this.createdOn});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    userName = json['userName'];
    userTypeId = json['userTypeId'];
    userType = json['UserType'];
    parentUserId = json['parentUserId'];
    phoneNumber = json['PhoneNumber'];
    email = json['Email'];
    password = json['Password'];
    address = json['Address'];
    countryId = json['CountryId'];
    countryName = json['countryName'];
    stateId = json['stateId'];
    stateName = json['stateName'];
    cityId = json['cityId'];
    cityName = json['cityName'];
    profilePic = json['ProfilePic'];
    isActive = json['IsActive'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['userName'] = this.userName;
    data['userTypeId'] = this.userTypeId;
    data['UserType'] = this.userType;
    data['parentUserId'] = this.parentUserId;
    data['PhoneNumber'] = this.phoneNumber;
    data['Email'] = this.email;
    data['Password'] = this.password;
    data['Address'] = this.address;
    data['CountryId'] = this.countryId;
    data['countryName'] = this.countryName;
    data['stateId'] = this.stateId;
    data['stateName'] = this.stateName;
    data['cityId'] = this.cityId;
    data['cityName'] = this.cityName;
    data['ProfilePic'] = this.profilePic;
    data['IsActive'] = this.isActive;
    data['createdOn'] = this.createdOn;
    return data;
  }
}
