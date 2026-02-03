class GetFavoriteListResponse {
  GetFavoriteListResponse({
    this.isError,
    this.isValidationFailed,
    this.errorCode,
    this.status,
    this.message,
    this.data,
  });

  GetFavoriteListResponse.fromJson(dynamic json) {
    isError = json['isError'];
    isValidationFailed = json['isValidationFailed'];
    errorCode = json['errorCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? isError;
  String? isValidationFailed;
  String? errorCode;
  String? status;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isError'] = isError;
    map['isValidationFailed'] = isValidationFailed;
    map['errorCode'] = errorCode;
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.products,
  });

  Data.fromJson(dynamic json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
  }

  List<Products>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Products {
  Products({
    this.productId,
    this.productVariantId,
    this.productName,
    this.productDescription,
    this.productCategoryId,
    this.productCategoryName,
    this.price,
    this.image,
    this.favourite,
    this.productVariant,
  });

  Products.fromJson(dynamic json) {
    productId = json['product_id'];
    productVariantId = json['product_variant_id'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    productCategoryId = json['product_category_id'];
    productCategoryName = json['product_category_name'];
    price = json['price'];
    image = json['image'];
    favourite = json['favourite'];
    // if (json['product_variant'] != null) {
    //   productVariant = [];
    //   json['product_variant'].forEach((v) {
    //     productVariant?.add(ProductVariant.fromJson(v));
    //   });
    // }
    productVariant = json['product_variant'] != null
        ? ProductVariant.fromJson(json['product_variant'])
        : null;
  }

  int? productId;
  int? productVariantId;
  String? productName;
  String? productDescription;
  int? productCategoryId;
  String? productCategoryName;
  double? price;
  String? image;
  int? favourite;

  // List<ProductVariant>? productVariant;
  ProductVariant? productVariant;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = productId;
    map['product_variant_id'] = productVariantId;
    map['product_name'] = productName;
    map['product_description'] = productDescription;
    map['product_category_id'] = productCategoryId;
    map['product_category_name'] = productCategoryName;
    map['price'] = price;
    map['image'] = image;
    map['favourite'] = favourite;
    // if (productVariant != null) {
    //   map['product_variant'] = productVariant?.map((v) => v.toJson()).toList();
    // }
    if (productVariant != null) {
      map['product_variant'] = productVariant?.toJson();
    }
    return map;
  }
}

// class ProductVariant {
//   ProductVariant({
//     this.id,
//     this.name,
//     this.attributeName,
//     this.attributeId,
//   });
//
//   ProductVariant.fromJson(dynamic json) {
//     id = json['id'];
//     name = json['name'];
//     attributeName = json['attribute_name'];
//     attributeId = json['attribute_id'];
//   }
//
//   int? id;
//   String? name;
//   String? attributeName;
//   int? attributeId;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['name'] = name;
//     map['attribute_name'] = attributeName;
//     map['attribute_id'] = attributeId;
//     return map;
//   }
// }
class ProductVariant {
  ProductVariant({
    this.color,
    this.material,
    this.steps,
  });

  ProductVariant.fromJson(dynamic json) {
    color = json['color'] != null ? Color.fromJson(json['color']) : null;
    material =
        json['material'] != null ? Material.fromJson(json['material']) : null;
    steps = json['steps'] != null ? Steps.fromJson(json['steps']) : null;
  }

  Color? color;
  Material? material;
  Steps? steps;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (color != null) {
      map['color'] = color?.toJson();
    }
    if (material != null) {
      map['material'] = material?.toJson();
    }
    if (steps != null) {
      map['steps'] = steps?.toJson();
    }
    return map;
  }
}

class Color {
  Color({
    this.id,
    this.name,
  });

  Color.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}

class Material {
  Material({
    this.id,
    this.name,
  });

  Material.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}

class Steps {
  Steps({
    this.id,
    this.name,
    this.attributeId,
  });

  Steps.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    attributeId = json['attribute_id'];
  }

  int? id;
  String? name;
  int? attributeId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['attribute_id'] = attributeId;
    return map;
  }
}
