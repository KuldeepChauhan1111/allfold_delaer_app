class ProductDetailsRequest {
  ProductDetailsRequest({
    this.token,
    this.productId,
    this.productAttributeValues,
  });

  String? token;
  int? productId;
  List<int>? productAttributeValues;
}
