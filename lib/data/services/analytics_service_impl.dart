import 'package:e_waste/domain/repositories/analytics_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class ScreenName {
  static const MAP_NAME = "Map";
  static const INFO_NAME = "Info";
  static const NEWS_NAME = "News";
  static const NEWS_DETAIL_NAME = "NewsDetail";
  static const REPORT_ILLEGAL_DUMP_NAME = "Illegal tip form";
}

class _CustomEventName {
  static const USER_ACTION_URL = "url_open";
}

class AnalyticsServiceImpl extends AnalyticsService {
  FirebaseAnalytics _analytics = FirebaseAnalytics();

  @override
  FirebaseAnalyticsObserver getAnalyticsObserver() {
    return FirebaseAnalyticsObserver(analytics: _analytics);
  }

  @override
  void didOpenUrl(UserActionUrl userActionUrl) {
    _analytics.logEvent(
        name: _CustomEventName.USER_ACTION_URL, parameters: userActionUrl.map);
  }
}
