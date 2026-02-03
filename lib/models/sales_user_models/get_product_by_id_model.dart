class GetProductByIdModel {
  List<Data>? data;
  bool? isSuccessful;
  int? code;
  String? message;

  GetProductByIdModel({this.data, this.isSuccessful, this.code, this.message});

  GetProductByIdModel.fromJson(Map<String, dynamic> json) {
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
  String? productCode;
  int? categoryId;
  String? categoryName;
  int? materialId;
  String? materialName;
  List<String>? productMaterial;
  int? uomId;
  String? uomName;
  String? itemDescription;
  String? productSKUId;
  String? size;
  bool? isFavourite;
  String? price;
  List<String>? productSize;

  Data(
      {this.productId,
        this.productName,
        this.imagePath,
        this.productCode,
        this.categoryId,
        this.categoryName,
        this.materialId,
        this.materialName,
        this.productMaterial,
        this.uomId,
        this.uomName,
        this.itemDescription,
        this.productSKUId,
        this.size,
        this.isFavourite,
        this.price,
        this.productSize});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['ProductId'];
    productName = json['ProductName'];
    imagePath = json['ImagePath'];
    productCode = json['ProductCode'];
    categoryId = json['CategoryId'];
    categoryName = json['CategoryName'];
    materialId = json['MaterialId'];
    materialName = json['MaterialName'];
    productMaterial = json['ProductMaterial'].cast<String>();
    uomId = json['UomId'];
    uomName = json['UomName'];
    itemDescription = json['ItemDescription'];
    productSKUId = json['ProductSKUId'];
    size = json['size'];
    isFavourite = json['IsFavourite'];
    price = json['Price'];
    productSize = json['ProductSize'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductId'] = this.productId;
    data['ProductName'] = this.productName;
    data['ImagePath'] = this.imagePath;
    data['ProductCode'] = this.productCode;
    data['CategoryId'] = this.categoryId;
    data['CategoryName'] = this.categoryName;
    data['MaterialId'] = this.materialId;
    data['MaterialName'] = this.materialName;
    data['ProductMaterial'] = this.productMaterial;
    data['UomId'] = this.uomId;
    data['UomName'] = this.uomName;
    data['ItemDescription'] = this.itemDescription;
    data['ProductSKUId'] = this.productSKUId;
    data['size'] = this.size;
    data['IsFavourite'] = this.isFavourite;
    data['Price'] = this.price;
    data['ProductSize'] = this.productSize;
    return data;
  }
}
