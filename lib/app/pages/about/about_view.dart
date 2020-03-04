import 'package:e_waste/app/widgets/analytics_screen.dart';
import 'package:e_waste/app/widgets/constants.dart';
import 'package:e_waste/data/services/analytics_service_impl.dart';
import 'package:e_waste/domain/repositories/analytics_service.dart';
import 'package:e_waste/domain/repositories/info_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

import 'about_controller.dart';

class AboutPage extends View {
  final AnalyticsService _analyticsService;
  final InfoRepository _infoRepository;

  AboutPage(this._analyticsService, this._infoRepository);

  @override
  State<StatefulWidget> createState() => _AboutState(_infoRepository);
}

class _AboutState extends ViewState<AboutPage, AboutController>
    with AnalyticsScreen {
  bool _isLoading = true;

  @override
  String get screenName => ScreenName.INFO_NAME;

  _AboutState(InfoRepository infoRepository)
      : super(AboutController(infoRepository)) {
    controller.initController(globalKey);
    setCurrentScreen();
  }

  @override
  Widget buildPage() {
    controller.context = context;
    configureCountryCode();
    return new Center(
      key: globalKey,
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
    controller.setCountryCode(Localizations.localeOf(context).countryCode);
    if (_isLoading) {
      controller.getInfo();
      _isLoading = false;
    }
  }

  _launchUrl(String url) async {
    widget._analyticsService.didOpenUrl(UserActionUrl(url));
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
