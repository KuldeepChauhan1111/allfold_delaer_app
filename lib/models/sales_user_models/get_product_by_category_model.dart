class GetProductByCategoryModel {
  List<Data>? data;
  bool? isSuccessful;
  int? code;
  String? message;

  GetProductByCategoryModel(
      {this.data, this.isSuccessful, this.code, this.message});

  GetProductByCategoryModel.fromJson(Map<String, dynamic> json) {
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
  int? productId;
  String? productName;
  String? imagePath;
  bool? isFavourite;

  Data({this.productId, this.productName, this.imagePath, this.isFavourite});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    imagePath = json['imagePath'];
    isFavourite = json['IsFavourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['imagePath'] = this.imagePath;
    data['IsFavourite'] = this.isFavourite;
    return data;
  }
}
