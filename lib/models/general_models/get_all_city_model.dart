class GetAllCityModel {
  List<Data>? data;
  bool? isSuccessful;
  int? code;
  String? message;

  GetAllCityModel({this.data, this.isSuccessful, this.code, this.message});

  GetAllCityModel.fromJson(Map<String, dynamic> json) {
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
  int? countryid;
  int? stateid;
  int? cityid;
  String? cityname;

  Data({this.countryid, this.stateid, this.cityid, this.cityname});

  Data.fromJson(Map<String, dynamic> json) {
    countryid = json['countryid'];
    stateid = json['stateid'];
    cityid = json['cityid'];
    cityname = json['cityname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryid'] = this.countryid;
    data['stateid'] = this.stateid;
    data['cityid'] = this.cityid;
    data['cityname'] = this.cityname;
    return data;
  }
}
