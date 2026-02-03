class OrderState {
  OrderState init() {
    return OrderState();
  }
}

class LoadingState extends OrderState {
  LoadingState();
}

class SuccessState extends OrderState {
  SuccessState();
}

class FailureState extends OrderState {
  FailureState();
}
