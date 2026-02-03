class ProductState {
  ProductState init() {
    return ProductState();
  }
}

class LoadingState extends ProductState {
  LoadingState();
}

class SuccessState extends ProductState {
  SuccessState();
}

class UpdateQuantityState extends ProductState {
  UpdateQuantityState();
}

class FailureState extends ProductState {
  FailureState();
}

class CartCountState extends ProductState {
  CartCountState();
}
