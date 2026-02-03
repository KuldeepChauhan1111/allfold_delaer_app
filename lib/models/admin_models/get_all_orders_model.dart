class GetAllOrdersModel {
  List<Data>? data;
  bool? isSuccessful;
  int? code;
  String? message;

  GetAllOrdersModel({this.data, this.isSuccessful, this.code, this.message});

  GetAllOrdersModel.fromJson(Map<String, dynamic> json) {
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
  int? salesOrderId;
  String? orderDate;
  String? userName;
  int? quantity;
  String? orderStatus;

  Data(
      {this.salesOrderId,
        this.orderDate,
        this.userName,
        this.quantity,
        this.orderStatus});

  Data.fromJson(Map<String, dynamic> json) {
    salesOrderId = json['salesOrderId'];
    orderDate = json['orderDate'];
    userName = json['userName'];
    quantity = json['quantity'];
    orderStatus = json['orderStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salesOrderId'] = this.salesOrderId;
    data['orderDate'] = this.orderDate;
    data['userName'] = this.userName;
    data['quantity'] = this.quantity;
    data['orderStatus'] = this.orderStatus;
    return data;
  }
}
