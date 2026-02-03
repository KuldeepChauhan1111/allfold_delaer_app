class FavoriteState {
  FavoriteState init() {
    return FavoriteState();
  }
}

class LoadingState extends FavoriteState {
  LoadingState();
}

class SuccessState extends FavoriteState {
  SuccessState();
}

class FailureState extends FavoriteState {
  FailureState();
}
