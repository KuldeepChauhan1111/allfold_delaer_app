class AllCategoryModel {
  List<Data>? data;
  bool? isSuccessful;
  int? code;
  String? message;

  AllCategoryModel({this.data, this.isSuccessful, this.code, this.message});

  AllCategoryModel.fromJson(Map<String, dynamic> json) {
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
  int? categoryId;
  String? categoryName;
  String? categoryImage;
  int? totalProducts;

  Data(
      {this.categoryId,
        this.categoryName,
        this.categoryImage,
        this.totalProducts});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['CategoryId'];
    categoryName = json['CategoryName'];
    categoryImage = json['CategoryImage'];
    totalProducts = json['TotalProducts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CategoryId'] = this.categoryId;
    data['CategoryName'] = this.categoryName;
    data['CategoryImage'] = this.categoryImage;
    data['TotalProducts'] = this.totalProducts;
    return data;
  }
}
