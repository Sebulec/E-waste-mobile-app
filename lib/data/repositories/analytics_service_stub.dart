import 'package:e_waste/domain/repositories/analytics_service.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

class AnalyticsServiceStub extends AnalyticsService {
  @override
  void didOpenUrl(UserActionUrl userActionUrl) {
    print("GOOGLE ANALYTICS : Did open URL" + userActionUrl.urlName);
  }

  @override
  FirebaseAnalyticsObserver getAnalyticsObserver() {
    return _FirebaseAnalyticsObserverStub();
  }
}

class _FirebaseAnalyticsObserverStub extends FirebaseAnalyticsObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    print("GOOGLE ANALYTICS: did push ${route}");
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    print("GOOGLE ANALYTICS: did replace ${newRoute}");
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    print("GOOGLE ANALYTICS: did pop ${route}");
  }
}
