class OutsideActionsManager {
  // sigleton
  static OutsideActionsManager _instance = OutsideActionsManager._internal();

  OutsideActionsManager._internal();
  factory OutsideActionsManager() => _instance;

  void navigateToStore() {
    print("Go to AppStore or Play Store");
  }
}
