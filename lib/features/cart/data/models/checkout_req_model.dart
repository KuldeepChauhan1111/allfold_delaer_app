class CheckoutReqModel {
  CheckoutReqModel({
    this.productid,
    this.quantity,
  });

  CheckoutReqModel.fromJson(dynamic json) {
    productid = json['productid'];
    quantity = json['quantity'];
  }

  int? productid;
  int? quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productid'] = productid;
    map['quantity'] = quantity;
    return map;
  }
}
