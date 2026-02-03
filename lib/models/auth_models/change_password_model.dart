class ChangePasswordModel {
  String? data;
  bool? isSuccessful;
  int? code;
  String? message;

  ChangePasswordModel({this.data, this.isSuccessful, this.code, this.message});

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'];
    isSuccessful = json['IsSuccessful'];
    code = json['Code'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Data'] = this.data;
    data['IsSuccessful'] = this.isSuccessful;
    data['Code'] = this.code;
    data['Message'] = this.message;
    return data;
  }
}
