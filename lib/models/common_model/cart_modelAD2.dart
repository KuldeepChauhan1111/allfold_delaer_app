// class CartModelAD2 {
//   List<ListData2>? listData2;
//
//   CartModelAD2({this.listData2});
//
//   CartModelAD2.fromJson(Map<String, dynamic> json) {
//     if (json['listData'] != null) {
//       listData2 = <ListData2>[];
//       json['listData'].forEach((v) {
//         listData2!.add(new ListData2.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.listData2 != null) {
//       data['listData'] = this.listData2!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class ListData2 {
//   String? imageUrl;
//   String? productName;
//   String? productId;
//   String? amount;
//   int? quantity;
//   String? productSKUId;
//   String? material;
//   String? size;
//   String? categoryName;
//   String? categoryId;
//   String? amountProTotal;
//
//   ListData2(
//       {this.imageUrl,
//         this.productName,
//         this.productId,
//         this.amount,
//         this.quantity,
//         this.productSKUId,
//         this.material,
//         this.size,
//         this.categoryName,
//         this.categoryId,
//         this.amountProTotal});
//
//   ListData2.fromJson(Map<String, dynamic> json) {
//     imageUrl = json['imageUrl'];
//     productName = json['productName'];
//     productId = json['productId'];
//     amount = json['amount'];
//     quantity = json['quantity'];
//     productSKUId = json['productSKUId'];
//     material = json['material'];
//     size = json['size'];
//     categoryName = json['categoryName'];
//     categoryId = json['categoryId'];
//     amountProTotal = json['amountProTotal'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['imageUrl'] = this.imageUrl;
//     data['productName'] = this.productName;
//     data['productId'] = this.productId;
//     data['amount'] = this.amount;
//     data['quantity'] = this.quantity;
//     data['productSKUId'] = this.productSKUId;
//     data['material'] = this.material;
//     data['size'] = this.size;
//     data['categoryName'] = this.categoryName;
//     data['categoryId'] = this.categoryId;
//     data['amountProTotal'] = this.amountProTotal;
//     return data;
//   }
// }
