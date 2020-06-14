import 'package:url_launcher/url_launcher.dart';

import 'analytics_service.dart';

class UrlOpener {
  final AnalyticsService _analyticsService;

  UrlOpener(this._analyticsService);

  openUrl(String url) async {
    _analyticsService.didOpenUrl(UserActionUrl(url));
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
