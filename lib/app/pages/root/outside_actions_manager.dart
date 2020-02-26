import 'package:launch_review/launch_review.dart';

class OutsideActionsManager {
  // sigleton
  static OutsideActionsManager _instance = OutsideActionsManager._internal();

  OutsideActionsManager._internal();
  factory OutsideActionsManager() => _instance;

  void navigateToStore() {
    print("Go to AppStore or Play Store");
    try {
      LaunchReview.launch();
    } catch (_) {
      print("Cannot open AppStore/PlayStore");
    }
  }
}
