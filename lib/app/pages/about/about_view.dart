import 'package:e_waste/app/widgets/constants.dart';
import 'package:e_waste/data/repositories/data_info_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

import 'about_controller.dart';

class AboutPage extends View {
  @override
  State<StatefulWidget> createState() => _AboutState();
}

class _AboutState extends ViewState<AboutPage, AboutController> {
  bool _isLoading = true;

  _AboutState() : super(AboutController(DataInfoRepository()));

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
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
