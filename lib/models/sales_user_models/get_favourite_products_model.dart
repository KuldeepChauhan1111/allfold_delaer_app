class GetFavouriteProductsModel {
  List<Data>? data;
  bool? isSuccessful;
  int? code;
  String? message;

  GetFavouriteProductsModel(
      {this.data, this.isSuccessful, this.code, this.message});

  GetFavouriteProductsModel.fromJson(Map<String, dynamic> json) {
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
  int? uomId;
  String? uomName;
  String? itemDescription;
  String? productSKUId;
  bool? isFavourite;
  int? favouriteId;
  String? price;
  String? size;

  Data(
      {this.productId,
        this.productName,
        this.imagePath,
        this.productCode,
        this.categoryId,
        this.categoryName,
        this.materialId,
        this.materialName,
        this.uomId,
        this.uomName,
        this.itemDescription,
        this.productSKUId,
        this.isFavourite,
        this.favouriteId,
        this.price,
        this.size});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['ProductId'];
    productName = json['ProductName'];
    imagePath = json['ImagePath'];
    productCode = json['ProductCode'];
    categoryId = json['categoryId'];
    categoryName = json['CategoryName'];
    materialId = json['materialId'];
    materialName = json['MaterialName'];
    uomId = json['uomId'];
    uomName = json['UomName'];
    itemDescription = json['ItemDescription'];
    productSKUId = json['ProductSKUId'];
    isFavourite = json['IsFavourite'];
    favouriteId = json['favouriteId'];
    price = json['Price'];
    size = json['Size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductId'] = this.productId;
    data['ProductName'] = this.productName;
    data['ImagePath'] = this.imagePath;
    data['ProductCode'] = this.productCode;
    data['categoryId'] = this.categoryId;
    data['CategoryName'] = this.categoryName;
    data['materialId'] = this.materialId;
    data['MaterialName'] = this.materialName;
    data['uomId'] = this.uomId;
    data['UomName'] = this.uomName;
    data['ItemDescription'] = this.itemDescription;
    data['ProductSKUId'] = this.productSKUId;
    data['IsFavourite'] = this.isFavourite;
    data['favouriteId'] = this.favouriteId;
    data['Price'] = this.price;
    data['Size'] = this.size;
    return data;
  }
}
