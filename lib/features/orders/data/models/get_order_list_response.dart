class GetOrderListResponse {
  GetOrderListResponse({
    this.isError,
    this.isValidationFailed,
    this.errorCode,
    this.status,
    this.data,
  });

  GetOrderListResponse.fromJson(dynamic json) {
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
    this.totalOrders,
    this.orderList,
  });

  Data.fromJson(dynamic json) {
    totalOrders = json['totalOrders'];
    if (json['orderList'] != null) {
      orderList = [];
      json['orderList'].forEach((v) {
        orderList?.add(OrderList.fromJson(v));
      });
    }
  }

  int? totalOrders;
  List<OrderList>? orderList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalOrders'] = totalOrders;
    map['orderList'] = orderList;
    if (orderList != null) {
      map['orderList'] = orderList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Products {
  Products({
    this.id,
    this.productId,
    this.name,
    this.quantity,
    this.price,
    this.priceExcludeTax,
    this.priceIncludeTax,
    this.taxes,
  });

  Products.fromJson(dynamic json) {
    id = json['id'];
    productId = json['product_id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    priceExcludeTax = json['price_exclude_tax'];
    priceIncludeTax = json['price_include_tax'];
    if (json['taxes'] != null) {
      taxes = [];
      json['taxes'].forEach((v) {
        taxes?.add(Taxes.fromJson(v));
      });
    }
  }

  int? id;
  int? productId;
  String? name;
  num? quantity;
  double? price;
  double? priceExcludeTax;
  double? priceIncludeTax;
  List<Taxes>? taxes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['product_id'] = productId;
    map['name'] = name;
    map['quantity'] = quantity;
    map['price'] = price;
    map['price_exclude_tax'] = priceExcludeTax;
    map['price_include_tax'] = priceIncludeTax;
    if (taxes != null) {
      map['taxes'] = taxes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Taxes {
  Taxes({
    this.taxId,
    this.name,
    this.amount,
    this.description,
  });

  Taxes.fromJson(dynamic json) {
    taxId = json['tax_id'];
    name = json['name'];
    amount = json['amount'];
    description = json['description'];
  }

  int? taxId;
  String? name;
  double? amount;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tax_id'] = taxId;
    map['name'] = name;
    map['amount'] = amount;
    map['description'] = description;
    return map;
  }
}

class Amount {
  Amount({
    this.amountUntaxed,
    this.amountTotal,
    this.formattedAmountTotal,
    this.formattedAmountUntaxed,
    this.groupsBySubtotal,
    this.subtotals,
    this.subtotalsOrder,
    this.displayTaxBase,
  });

  Amount.fromJson(dynamic json) {
    amountUntaxed = json['amount_untaxed'];
    amountTotal = json['amount_total'];
    formattedAmountTotal = json['formatted_amount_total'];
    formattedAmountUntaxed = json['formatted_amount_untaxed'];
    groupsBySubtotal = json['groups_by_subtotal'] != null
        ? GroupsBySubtotal.fromJson(json['groups_by_subtotal'])
        : null;
    if (json['subtotals'] != null) {
      subtotals = [];
      json['subtotals'].forEach((v) {
        subtotals?.add(Subtotals.fromJson(v));
      });
    }
    subtotalsOrder = json['subtotals_order'] != null
        ? json['subtotals_order'].cast<String>()
        : [];
    displayTaxBase = json['display_tax_base'];
  }

  double? amountUntaxed;
  double? amountTotal;
  String? formattedAmountTotal;
  String? formattedAmountUntaxed;
  GroupsBySubtotal? groupsBySubtotal;
  List<Subtotals>? subtotals;
  List<String>? subtotalsOrder;
  bool? displayTaxBase;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount_untaxed'] = amountUntaxed;
    map['amount_total'] = amountTotal;
    map['formatted_amount_total'] = formattedAmountTotal;
    map['formatted_amount_untaxed'] = formattedAmountUntaxed;
    if (groupsBySubtotal != null) {
      map['groups_by_subtotal'] = groupsBySubtotal?.toJson();
    }
    if (subtotals != null) {
      map['subtotals'] = subtotals?.map((v) => v.toJson()).toList();
    }
    map['subtotals_order'] = subtotalsOrder;
    map['display_tax_base'] = displayTaxBase;
    return map;
  }
}

class Subtotals {
  Subtotals({
    this.name,
    this.amount,
    this.formattedAmount,
  });

  Subtotals.fromJson(dynamic json) {
    name = json['name'];
    amount = json['amount'];
    formattedAmount = json['formatted_amount'];
  }

  String? name;
  double? amount;
  String? formattedAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['amount'] = amount;
    map['formatted_amount'] = formattedAmount;
    return map;
  }
}

class GroupsBySubtotal {
  GroupsBySubtotal({
    this.untaxedAmount,
  });

  GroupsBySubtotal.fromJson(dynamic json) {
    if (json['Untaxed Amount'] != null) {
      untaxedAmount = [];
      json['Untaxed Amount'].forEach((v) {
        untaxedAmount?.add(UntaxedAmount.fromJson(v));
      });
    }
  }

  List<UntaxedAmount>? untaxedAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (untaxedAmount != null) {
      map['Untaxed Amount'] = untaxedAmount?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class UntaxedAmount {
  UntaxedAmount({
    this.groupKey,
    this.taxGroupId,
    this.taxGroupName,
    this.taxGroupAmount,
    this.taxGroupBaseAmount,
    this.formattedTaxGroupAmount,
    this.formattedTaxGroupBaseAmount,
    this.hideBaseAmount,
  });

  UntaxedAmount.fromJson(dynamic json) {
    groupKey = json['group_key'];
    taxGroupId = json['tax_group_id'];
    taxGroupName = json['tax_group_name'];
    taxGroupAmount = json['tax_group_amount'];
    taxGroupBaseAmount = json['tax_group_base_amount'];
    formattedTaxGroupAmount = json['formatted_tax_group_amount'];
    formattedTaxGroupBaseAmount = json['formatted_tax_group_base_amount'];
    hideBaseAmount = json['hide_base_amount'];
  }

  int? groupKey;
  int? taxGroupId;
  String? taxGroupName;
  double? taxGroupAmount;
  double? taxGroupBaseAmount;
  String? formattedTaxGroupAmount;
  String? formattedTaxGroupBaseAmount;
  bool? hideBaseAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['group_key'] = groupKey;
    map['tax_group_id'] = taxGroupId;
    map['tax_group_name'] = taxGroupName;
    map['tax_group_amount'] = taxGroupAmount;
    map['tax_group_base_amount'] = taxGroupBaseAmount;
    map['formatted_tax_group_amount'] = formattedTaxGroupAmount;
    map['formatted_tax_group_base_amount'] = formattedTaxGroupBaseAmount;
    map['hide_base_amount'] = hideBaseAmount;
    return map;
  }
}

class InprogressOrders {
  InprogressOrders({
    this.orderId,
    this.order,
    this.partnerId,
    this.customerName,
    this.state,
    this.stateValue,
    this.amount,
    this.date,
    this.products,
  });

  InprogressOrders.fromJson(dynamic json) {
    orderId = json['order_id'];
    order = json['order'];
    partnerId = json['partner_id'];
    customerName = json['customer_name'];
    state = json['state'];
    stateValue = json['state_value'];
    amount = json['amount'] != null ? Amount.fromJson(json['amount']) : null;
    date = json['date'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
  }

  int? orderId;
  String? order;
  int? partnerId;
  String? customerName;
  String? state;
  String? stateValue;
  Amount? amount;
  String? date;
  List<Products>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = orderId;
    map['order'] = order;
    map['partner_id'] = partnerId;
    map['customer_name'] = customerName;
    map['state'] = state;
    map['state_value'] = stateValue;
    if (amount != null) {
      map['amount'] = amount?.toJson();
    }
    map['date'] = date;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class OrderList {
  OrderList({
    this.orderId,
    this.order,
    this.partnerId,
    this.customerName,
    this.state,
    this.stateValue,
    this.amount,
    this.date,
    this.products,
  });

  OrderList.fromJson(dynamic json) {
    orderId = json['order_id'];
    order = json['order'];
    partnerId = json['partner_id'];
    customerName = json['customer_name'];
    state = json['state'];
    stateValue = json['state_value'];
    amount = json['amount'] != null ? Amount.fromJson(json['amount']) : null;
    date = json['date'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
  }

  int? orderId;
  String? order;
  int? partnerId;
  String? customerName;
  String? state;
  String? stateValue;
  Amount? amount;
  String? date;
  List<Products>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = orderId;
    map['order'] = order;
    map['partner_id'] = partnerId;
    map['customer_name'] = customerName;
    map['state'] = state;
    map['state_value'] = stateValue;
    if (amount != null) {
      map['amount'] = amount?.toJson();
    }
    map['date'] = date;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
