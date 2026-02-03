class GetSalesManListModel {
  List<Data>? data;
  bool? isSuccessful;
  int? code;
  String? message;

  GetSalesManListModel({this.data, this.isSuccessful, this.code, this.message});

  GetSalesManListModel.fromJson(Map<String, dynamic> json) {
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
  String? profilePic;
  String? phoneNumber;
  String? email;

  Data(
      {this.userId,
        this.userName,
        this.profilePic,
        this.phoneNumber,
        this.email});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    profilePic = json['ProfilePic'];
    phoneNumber = json['PhoneNumber'];
    email = json['Email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['ProfilePic'] = this.profilePic;
    data['PhoneNumber'] = this.phoneNumber;
    data['Email'] = this.email;
    return data;
  }
}
