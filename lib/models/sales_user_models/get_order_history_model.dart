class GetOrderHistoryModel {
  List<Data>? data;
  bool? isSuccessful;
  int? code;
  String? message;

  GetOrderHistoryModel({this.data, this.isSuccessful, this.code, this.message});

  GetOrderHistoryModel.fromJson(Map<String, dynamic> json) {
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
  int? quantity;
  String? orderDate;
  String? orderStatus;

  Data({this.salesOrderId, this.quantity, this.orderDate, this.orderStatus});

  Data.fromJson(Map<String, dynamic> json) {
    salesOrderId = json['salesOrderId'];
    quantity = json['quantity'];
    orderDate = json['orderDate'];
    orderStatus = json['orderStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salesOrderId'] = this.salesOrderId;
    data['quantity'] = this.quantity;
    data['orderDate'] = this.orderDate;
    data['orderStatus'] = this.orderStatus;
    return data;
  }
}
