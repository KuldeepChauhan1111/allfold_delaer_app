class CheckoutResponse {
  CheckoutResponse({
      this.isError, 
      this.isValidationFailed, 
      this.errorCode, 
      this.status, 
      this.message, 
      this.data,});

  CheckoutResponse.fromJson(dynamic json) {
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
      this.order,});

  Data.fromJson(dynamic json) {
    if (json['order'] != null) {
      order = [];
      json['order'].forEach((v) {
        order?.add(Order.fromJson(v));
      });
    }
  }
  List<Order>? order;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (order != null) {
      map['order'] = order?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Order {
  Order({
      this.name, 
      this.orderId, 
      this.lineIds,});

  Order.fromJson(dynamic json) {
    name = json['name'];
    orderId = json['order_id'];
    lineIds = json['line_ids'] != null ? json['line_ids'].cast<int>() : [];
  }
  String? name;
  int? orderId;
  List<int>? lineIds;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['order_id'] = orderId;
    map['line_ids'] = lineIds;
    return map;
  }

}