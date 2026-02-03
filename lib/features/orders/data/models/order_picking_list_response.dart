class OrderPickingListResponse {
  String? isError;
  String? isValidationFailed;
  String? errorCode;
  String? status;
  List<PickingData>? data;

  OrderPickingListResponse(
      {this.isError,
        this.isValidationFailed,
        this.errorCode,
        this.status,
        this.data});

  OrderPickingListResponse.fromJson(Map<String, dynamic> json) {
    isError = json['isError'];
    isValidationFailed = json['isValidationFailed'];
    errorCode = json['errorCode'];
    status = json['status'];
    if (json['data'] != null) {
      data = <PickingData>[];
      json['data'].forEach((v) {
        data!.add(new PickingData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isError'] = this.isError;
    data['isValidationFailed'] = this.isValidationFailed;
    data['errorCode'] = this.errorCode;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PickingData {
  String? deliveryOrder;
  String? status;
  List<Products>? products;
  Transpoter? transpoter;

  PickingData({this.deliveryOrder, this.status, this.products, this.transpoter});

  PickingData.fromJson(Map<String, dynamic> json) {
    deliveryOrder = json['delivery_order'];
    status = json['status'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    transpoter = json['transpoter'] != null
        ? new Transpoter.fromJson(json['transpoter'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['delivery_order'] = this.deliveryOrder;
    data['status'] = this.status;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.transpoter != null) {
      data['transpoter'] = this.transpoter!.toJson();
    }
    return data;
  }
}

class Products {
  int? productId;
  String? productName;
  double? quantity;

  Products({this.productId, this.productName, this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['quantity'] = this.quantity;
    return data;
  }
}

class Transpoter {
  String? driverName;
  String? driverContact;
  String? vehicleNumber;
  String? notes;

  Transpoter(
      {this.driverName, this.driverContact, this.vehicleNumber, this.notes});

  Transpoter.fromJson(Map<String, dynamic> json) {
    driverName = json['driverName'];
    driverContact = json['driverContact'];
    vehicleNumber = json['vehicleNumber'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driverName'] = this.driverName;
    data['driverContact'] = this.driverContact;
    data['vehicleNumber'] = this.vehicleNumber;
    data['notes'] = this.notes;
    return data;
  }
}
