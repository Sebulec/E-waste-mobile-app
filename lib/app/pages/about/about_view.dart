import 'package:e_waste/app/widgets/analytics_screen.dart';
import 'package:e_waste/app/widgets/constants.dart';
import 'package:e_waste/data/repositories/data_info_repository.dart';
import 'package:e_waste/data/services/analytics_service_impl.dart';
import 'package:e_waste/domain/repositories/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

import 'about_controller.dart';

class AboutPage extends View {
  final AnalyticsService _analyticsService;

  AboutPage(this._analyticsService);

  @override
  State<StatefulWidget> createState() => _AboutState();
}

class _AboutState extends ViewState<AboutPage, AboutController>
    with AnalyticsScreen {
  bool _isLoading = true;

  @override
  String get screenName => ScreenName.INFO_NAME;

  _AboutState() : super(AboutController(DataInfoRepository())) {
    setCurrentScreen();
  }

  @override
  Widget buildPage() {
    configureCountryCode();
    return new Center(
      child: _isLoading ? CircularProgressIndicator() : _buildHtmlView(),
    );
  }

  Widget _buildHtmlView() => SingleChildScrollView(
        child: Html(
          data: controller.info?.htmlText ?? "",
          padding: EdgeInsets.all(EWasteLayout.PADDING),
          onLinkTap: _launchUrl,
        ),
      );

  void configureCountryCode() {
    if (_isLoading) {
      controller.getInfo();
      _isLoading = false;
    }
    controller.setCountryCode(Localizations.localeOf(context).countryCode);
  }

  _launchUrl(String url) async {
    widget._analyticsService.didOpenUrl(UserActionUrl(url));
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
