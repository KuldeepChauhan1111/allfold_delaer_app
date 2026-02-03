class CartModelAD {
  List<ListData>? listData;

  CartModelAD({this.listData});

  CartModelAD.fromJson(Map<String, dynamic> json) {
    if (json['listData'] != null) {
      listData = <ListData>[];
      json['listData'].forEach((v) {
        listData!.add(new ListData.fromJson(v));
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

class ListData {
  String? imageUrl;
  String? productName;
  String? productId;
  String? amount;
  String? quantity;
  String? productSKUId;
  String? material;
  String? size;
  String? categoryName;
  String? categoryId;
  String? amountProTotal;

  ListData(
      {this.imageUrl,
        this.productName,
        this.productId,
        this.amount,
        this.quantity,
        this.productSKUId,
        this.material,
        this.size,
        this.categoryName,
        this.categoryId,
        this.amountProTotal});

  ListData.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    productName = json['productName'];
    productId = json['productId'];
    amount = json['amount'];
    quantity = json['quantity'];
    productSKUId = json['productSKUId'];
    material = json['material'];
    size = json['size'];
    categoryName = json['categoryName'];
    categoryId = json['categoryId'];
    amountProTotal = json['amountProTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['productName'] = this.productName;
    data['productId'] = this.productId;
    data['amount'] = this.amount;
    data['quantity'] = this.quantity;
    data['productSKUId'] = this.productSKUId;
    data['material'] = this.material;
    data['size'] = this.size;
    data['categoryName'] = this.categoryName;
    data['categoryId'] = this.categoryId;
    data['amountProTotal'] = this.amountProTotal;
    return data;
  }
}
