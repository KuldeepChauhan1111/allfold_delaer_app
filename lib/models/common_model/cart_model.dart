class CartModel {
  List<ListDataSales>? listData;

  CartModel({this.listData});

  CartModel.fromJson(Map<String, dynamic> json) {
    if (json['listData'] != null) {
      listData = <ListDataSales>[];
      json['listData'].forEach((v) {
        listData!.add(new ListDataSales.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listData != null) {
      data['listData'] = this.listData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListDataSales {
  String? imageUrl;
  String? productName;
  String? productId;
  String? quantity;
  String? material;
  String? size;
  String? categoryName;
  String? categoryId;

  ListDataSales(
      {this.imageUrl,
        this.productName,
        this.productId,
        this.quantity,
        this.material,
        this.size,
        this.categoryName,
        this.categoryId});

  ListDataSales.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    productName = json['productName'];
    productId = json['productId'];
    quantity = json['quantity'];
    material = json['material'];
    size = json['size'];
    categoryName = json['categoryName'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['productName'] = this.productName;
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    data['material'] = this.material;
    data['size'] = this.size;
    data['categoryName'] = this.categoryName;
    data['categoryId'] = this.categoryId;
    return data;
  }
}
