class CategoriesState {
  CategoriesState init() {
    return CategoriesState();
  }
}

class LoadingState extends CategoriesState {
  LoadingState();
}

class SuccessState extends CategoriesState {
  SuccessState();
}

class FailureState extends CategoriesState {
  FailureState();
}
