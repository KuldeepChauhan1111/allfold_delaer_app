class SalesProductsViewModel {
  Data? data;
  bool? isSuccessful;
  int? code;
  String? message;

  SalesProductsViewModel(
      {this.data, this.isSuccessful, this.code, this.message});

  SalesProductsViewModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
    isSuccessful = json['IsSuccessful'];
    code = json['Code'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    data['IsSuccessful'] = this.isSuccessful;
    data['Code'] = this.code;
    data['Message'] = this.message;
    return data;
  }
}

class Data {
  List<Products>? products;
  List<Category>? category;
  List<BannerList>? banner;

  Data({this.products, this.category, this.banner});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Products'] != null) {
      products = <Products>[];
      json['Products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    if (json['Category'] != null) {
      category = <Category>[];
      json['Category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['Banner'] != null) {
      banner = <BannerList>[];
      json['Banner'].forEach((v) {
        banner!.add(new BannerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['Products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['Category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.banner != null) {
      data['Banner'] = this.banner!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? productViewStatusReferenceId;
  int? productId;
  String? productName;
  String? imagePath;
  int? productViewStatusId;
  String? viewStatus;
  bool? isFavourite;

  Products(
      {this.productViewStatusReferenceId,
        this.productId,
        this.productName,
        this.imagePath,
        this.productViewStatusId,
        this.viewStatus,
        this.isFavourite});

  Products.fromJson(Map<String, dynamic> json) {
    productViewStatusReferenceId = json['productViewStatusReferenceId'];
    productId = json['productId'];
    productName = json['productName'];
    imagePath = json['imagePath'];
    productViewStatusId = json['productViewStatusId'];
    viewStatus = json['viewStatus'];
    isFavourite = json['IsFavourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productViewStatusReferenceId'] = this.productViewStatusReferenceId;
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['imagePath'] = this.imagePath;
    data['productViewStatusId'] = this.productViewStatusId;
    data['viewStatus'] = this.viewStatus;
    data['IsFavourite'] = this.isFavourite;
    return data;
  }
}

class Category {
  int? categoryId;
  String? categoryName;
  String? categoryImage;

  Category({this.categoryId, this.categoryName, this.categoryImage});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    categoryImage = json['categoryImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['categoryImage'] = this.categoryImage;
    return data;
  }
}

class BannerList {
  int? bannerId;
  String? bannerTitle;
  String? bannerDescription;
  String? bannerImage;

  BannerList(
      {this.bannerId,
        this.bannerTitle,
        this.bannerDescription,
        this.bannerImage});

  BannerList.fromJson(Map<String, dynamic> json) {
    bannerId = json['bannerId'];
    bannerTitle = json['bannerTitle'];
    bannerDescription = json['bannerDescription'];
    bannerImage = json['bannerImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bannerId'] = this.bannerId;
    data['bannerTitle'] = this.bannerTitle;
    data['bannerDescription'] = this.bannerDescription;
    data['bannerImage'] = this.bannerImage;
    return data;
  }
}
