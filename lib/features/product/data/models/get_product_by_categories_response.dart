class GetProductByCategoriesResponse {
  GetProductByCategoriesResponse({
    this.isError,
    this.isValidationFailed,
    this.errorCode,
    this.status,
    this.data,
  });

  GetProductByCategoriesResponse.fromJson(dynamic json) {
    isError = json['isError'];
    isValidationFailed = json['isValidationFailed'];
    errorCode = json['errorCode'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? isError;
  String? isValidationFailed;
  String? errorCode;
  String? status;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isError'] = isError;
    map['isValidationFailed'] = isValidationFailed;
    map['errorCode'] = errorCode;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.productInfo,
  });

  Data.fromJson(dynamic json) {
    if (json['productInfo'] != null) {
      productInfo = [];
      json['productInfo'].forEach((v) {
        productInfo?.add(ProductInfo.fromJson(v));
      });
    }
  }

  List<ProductInfo>? productInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (productInfo != null) {
      map['productInfo'] = productInfo?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ProductInfo {
  ProductInfo({
    this.productId,
    this.productName,
    this.productDescription,
    this.productImages,
    this.productCategoryId,
    this.productCategoryName,
    this.productVariant,
    this.allVariants,
    this.price,
    this.favourite,
    this.image,
  });

  ProductInfo.fromJson(dynamic json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    if (json['product_images'] != null) {
      productImages = [];
      json['product_images'].forEach((v) {
        productImages?.add(v);
      });
    }
    productCategoryId = json['product_category_id'];
    productCategoryName = json['product_category_name'];
    productVariant = json['product_variant'];
    if (json['all_variants'] != null) {
      allVariants = [];
      json['all_variants'].forEach((v) {
        allVariants?.add(v);
      });
    }
    price = json['price'];
    favourite = json['favourite'];
    image = json['image'];
  }

  int? productId;
  String? productName;
  String? productDescription;
  List<dynamic>? productImages;
  int? productCategoryId;
  String? productCategoryName;
  dynamic productVariant;
  List<dynamic>? allVariants;
  double? price;
  int? favourite;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = productId;
    map['product_name'] = productName;
    map['product_description'] = productDescription;
    if (productImages != null) {
      map['product_images'] = productImages?.map((v) => v.toJson()).toList();
    }
    map['product_category_id'] = productCategoryId;
    map['product_category_name'] = productCategoryName;
    map['product_variant'] = productVariant;
    if (allVariants != null) {
      map['all_variants'] = allVariants?.map((v) => v.toJson()).toList();
    }
    map['price'] = price;
    map['favourite'] = favourite;
    map['image'] = image;
    return map;
  }
}
