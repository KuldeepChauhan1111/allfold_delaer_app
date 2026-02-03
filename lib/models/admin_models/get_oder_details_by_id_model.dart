class GetOrderDetailsByIdModel {
  List<Data>? data;
  bool? isSuccessful;
  int? code;
  String? message;

  GetOrderDetailsByIdModel(
      {this.data, this.isSuccessful, this.code, this.message});

  GetOrderDetailsByIdModel.fromJson(Map<String, dynamic> json) {
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
  int? salesOrderDetailId;
  int? quantity;
  int? categoryId;
  int? productId;
  String? productSKUId;
  String? categoryName;
  String? productName;
  String? imagePath;
  String? orderDate;
  String? orderStatus;
  String? materialName;
  String? size;
  // int? amount;
  int? amountProTotal;
  String? price;

  Data(
      {this.salesOrderDetailId,
        this.quantity,
        this.categoryId,
        this.productId,
        this.productSKUId,
        this.categoryName,
        this.productName,
        this.imagePath,
        this.orderDate,
        this.orderStatus,
        this.materialName,
        this.size,
        // this.amount,
        this.amountProTotal,
        this.price});

  Data.fromJson(Map<String, dynamic> json) {
    salesOrderDetailId = json['salesOrderDetailId'];
    quantity = json['quantity'];
    categoryId = json['categoryId'];
    productId = json['ProductId'];
    productSKUId = json['productSKUId'];
    categoryName = json['categoryName'];
    productName = json['productName'];
    imagePath = json['ImagePath'];
    orderDate = json['orderDate'];
    orderStatus = json['orderStatus'];
    materialName = json['materialName'];
    size = json['size'];
    // amount = json['amount'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salesOrderDetailId'] = this.salesOrderDetailId;
    data['quantity'] = this.quantity;
    data['categoryId'] = this.categoryId;
    data['ProductId'] = this.productId;
    data['productSKUId'] = this.productSKUId;
    data['categoryName'] = this.categoryName;
    data['productName'] = this.productName;
    data['ImagePath'] = this.imagePath;
    data['orderDate'] = this.orderDate;
    data['orderStatus'] = this.orderStatus;
    data['materialName'] = this.materialName;
    data['size'] = this.size;
    // data['amount'] = this.amount;
    data['price'] = this.price;
    return data;
  }
}
