class DashboardState {
  DashboardState init() {
    return DashboardState();
  }
}

class LoadingState extends DashboardState {
  LoadingState();
}

class SuccessState extends DashboardState {
  SuccessState();
}

class FailureState extends DashboardState {
  FailureState();
}
