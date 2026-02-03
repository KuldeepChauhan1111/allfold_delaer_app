class CartState {
  CartState init() {
    return CartState();
  }
}

class LoadingState extends CartState {
  LoadingState();
}

class SuccessState extends CartState {
  SuccessState();
}

class SuccessStateCheckout extends CartState {
  SuccessStateCheckout();
}

class FailureState extends CartState {
  FailureState();
}
