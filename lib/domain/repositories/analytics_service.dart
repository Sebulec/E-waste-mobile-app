import 'package:firebase_analytics/observer.dart';

class UserActionUrl {
  final String urlName;

  UserActionUrl(this.urlName);

  get map => {"url": urlName};
}

abstract class AnalyticsService {
  void didOpenUrl(UserActionUrl userActionUrl);
  FirebaseAnalyticsObserver getAnalyticsObserver();
}
