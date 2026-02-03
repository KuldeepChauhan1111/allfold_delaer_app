class ProductDetailsResponse {
  ProductDetailsResponse({
    this.isError,
    this.isValidationFailed,
    this.errorCode,
    this.status,
    this.data,
  });

  ProductDetailsResponse.fromJson(dynamic json) {
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
    this.variantDescription,
    this.productImages,
    this.productCategoryId,
    this.productCategoryName,
    this.price,
    this.image,
    this.productVariantId,
    this.productVariant,
    this.allVariants,
    this.favourite,
    this.totalIncluded,
    this.totalExcluded,
    this.qty,
    this.calculatedPrice,
    this.isExistInPrefList,
    this.selectedColor,
    this.selectedSize,
    this.selectedMaterial,
    this.taxes,
  });

  ProductInfo.fromJson(dynamic json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    variantDescription = json['variant_description'];
    productImages = json['product_images'] != null
        ? json['product_images'].cast<String>()
        : [];
    productCategoryId = json['product_category_id'];
    productCategoryName = json['product_category_name'];
    price = json['price'];
    image = json['image'];
    productVariantId = json['product_variant_id'];
    // if (json['product_variant'] != null) {
    //   productVariant = [];
    //   json['product_variant'].forEach((v) {
    //     productVariant?.add(ProductVariant.fromJson(v));
    //   });
    // }
    productVariant = json['product_variant'] != null
        ? ProductVariant.fromJson(json['product_variant'])
        : null;
    if (json['all_variants'] != null) {
      allVariants = [];
      json['all_variants'].forEach((v) {
        allVariants?.add(AllVariants.fromJson(v));
      });
    }
    favourite = json['favourite'];
    totalIncluded = json['total_included'];
    totalExcluded = json['total_excluded'];
    qty = json['qty'];
    calculatedPrice = json['calculatedPrice'];
    isExistInPrefList = json['isExistInPrefList'];
    selectedColor = json['selectedColor'] != null
        ? Color.fromJson(json['selectedColor'])
        : null;
    selectedSize = json['selectedSize'] != null
        ? Steps.fromJson(json['selectedSize'])
        : null;
    selectedMaterial = json['selectedMaterial'] != null
        ? Material.fromJson(json['selectedMaterial'])
        : null;
    if (json['taxes'] != null) {
      taxes = [];
      json['taxes'].forEach((v) {
        taxes?.add(Taxes.fromJson(v));
      });
    }
  }

  int? productId;
  String? productName;
  String? productDescription;
  String? variantDescription;
  List<String>? productImages;
  int? productCategoryId;
  String? productCategoryName;
  double? price;
  double? totalIncluded;
  double? totalExcluded;
  int? productVariantId;

  // List<ProductVariant>? productVariant;
  ProductVariant? productVariant;
  List<AllVariants>? allVariants;
  int? favourite;
  int? qty;
  double? calculatedPrice;
  bool? isExistInPrefList;
  String? image;
  Color? selectedColor;
  Steps? selectedSize;
  Material? selectedMaterial;
  List<Taxes>? taxes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = productId;
    map['product_name'] = productName;
    map['product_description'] = productDescription;
    map['variant_description'] = variantDescription;
    map['product_images'] = productImages;
    map['product_category_id'] = productCategoryId;
    map['product_category_name'] = productCategoryName;
    map['price'] = price;
    map['product_variant_id'] = productVariantId;
    // if (productVariant != null) {
    //   map['product_variant'] = productVariant?.map((v) => v.toJson()).toList();
    // }
    if (productVariant != null) {
      map['product_variant'] = productVariant?.toJson();
    }
    if (allVariants != null) {
      map['all_variants'] = allVariants?.map((v) => v.toJson()).toList();
    }
    map['favourite'] = favourite;
    map['total_included'] = totalIncluded;
    map['total_excluded'] = totalExcluded;
    map['qty'] = qty;
    map['calculatedPrice'] = calculatedPrice;
    map['isExistInPrefList'] = isExistInPrefList;
    map['image'] = image;
    map['selectedColor'] = selectedColor;
    map['selectedSize'] = selectedSize;
    map['selectedMaterial'] = selectedMaterial;
    if (taxes != null) {
      map['taxes'] = taxes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class AllVariants {
  AllVariants({
    this.color,
    this.steps,
    this.material,
  });

  AllVariants.fromJson(dynamic json) {
    if (json['color'] != null) {
      color = [];
      json['color'].forEach((v) {
        color?.add(Color.fromJson(v));
      });
    }
    if (json['steps'] != null) {
      steps = [];
      json['steps'].forEach((v) {
        steps?.add(Steps.fromJson(v));
      });
    }
    if (json['material'] != null) {
      material = [];
      json['material'].forEach((v) {
        material?.add(Material.fromJson(v));
      });
    }
  }

  List<Color>? color;
  List<Steps>? steps;
  List<Material>? material;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (color != null) {
      map['color'] = color?.map((v) => v.toJson()).toList();
    }
    if (steps != null) {
      map['steps'] = steps?.map((v) => v.toJson()).toList();
    }
    if (material != null) {
      map['material'] = material?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Color {
  Color({
    this.id,
    this.name,
    this.attributeId,
    this.htmlColor,
  });

  Color.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    attributeId = json['attribute_id'];
    htmlColor = json['html_color'];
  }

  int? id;
  String? name;
  int? attributeId;
  String? htmlColor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['attribute_id'] = attributeId;
    map['html_color'] = htmlColor;
    return map;
  }
}

class Material {
  Material({
    this.id,
    this.name,
    this.attributeId,
  });

  Material.fromJson(dynamic json) {
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

class Taxes {
  Taxes({
    this.taxId,
    this.name,
    this.amount,
    this.description,
  });

  Taxes.fromJson(dynamic json) {
    taxId = json['tax_id'];
    name = json['name'];
    amount = json['amount'];
    description = json['description'];
  }

  int? taxId;
  String? name;
  double? amount;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tax_id'] = taxId;
    map['name'] = name;
    map['amount'] = amount;
    map['description'] = description;
    return map;
  }
}
