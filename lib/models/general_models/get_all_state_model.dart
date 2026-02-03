class GetAllStateModel {
  List<Data>? data;
  bool? isSuccessful;
  int? code;
  String? message;

  GetAllStateModel({this.data, this.isSuccessful, this.code, this.message});

  GetAllStateModel.fromJson(Map<String, dynamic> json) {
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
  int? countryId;
  int? stateId;
  String? stateName;

  Data({this.countryId, this.stateId, this.stateName});

  Data.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'];
    stateId = json['stateId'];
    stateName = json['stateName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryId'] = this.countryId;
    data['stateId'] = this.stateId;
    data['stateName'] = this.stateName;
    return data;
  }
}
