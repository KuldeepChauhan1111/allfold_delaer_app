class GetCategoriesResponse {
  GetCategoriesResponse({
    this.isError,
    this.isValidationFailed,
    this.errorCode,
    this.status,
    this.data,
  });

  GetCategoriesResponse.fromJson(dynamic json) {
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
    this.categories,
  });

  Data.fromJson(dynamic json) {
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
  }

  List<Categories>? categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Categories {
  Categories({
    this.categoryId,
    this.category,
    this.image,
    this.parentCategoryInfo,
    this.subCategories,
    this.productsCount,
  });

  Categories.fromJson(dynamic json) {
    categoryId = json['category_id'];
    category = json['category'];
    image = json['image'];
    if (json['parentCategoryInfo'] != null) {
      parentCategoryInfo = [];
      json['parentCategoryInfo'].forEach((v) {
        parentCategoryInfo?.add(ParentCategoryInfo.fromJson(v));
      });
    }
    subCategories = json['sub_categories'];
    productsCount = json['products_count'];
  }

  int? categoryId;
  String? category;
  String? image;
  List<ParentCategoryInfo>? parentCategoryInfo;
  int? subCategories;
  int? productsCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_id'] = categoryId;
    map['category'] = category;
    map['image'] = image;
    if (parentCategoryInfo != null) {
      map['parentCategoryInfo'] =
          parentCategoryInfo?.map((v) => v.toJson()).toList();
    }
    map['sub_categories'] = subCategories;
    map['products_count'] = productsCount;
    return map;
  }
}

class ParentCategoryInfo {
  ParentCategoryInfo({
    this.parentCategoryId,
    this.parentCategoryName,
    this.productsCount,
  });

  ParentCategoryInfo.fromJson(dynamic json) {
    parentCategoryId = json['parentCategoryId'];
    parentCategoryName = json['parentCategoryName'];
    productsCount = json['products_count'];
  }

  int? parentCategoryId;
  String? parentCategoryName;
  int? productsCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['parentCategoryId'] = parentCategoryId;
    map['parentCategoryName'] = parentCategoryName;
    map['products_count'] = productsCount;
    return map;
  }
}
