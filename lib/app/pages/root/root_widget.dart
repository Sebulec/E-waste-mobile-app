import 'dart:ui';

import 'package:e_waste/app/pages/about/about_view.dart';
import 'package:e_waste/app/pages/home/home_view.dart';
import 'package:e_waste/app/pages/news/news_view.dart';
import 'package:e_waste/app/pages/root/outside_actions_manager.dart';
import 'package:e_waste/app/widgets/constants.dart';
import 'package:e_waste/app/widgets/custom_dialog.dart';
import 'package:e_waste/app/widgets/ui_factory/interfaces/bottom_tab_bar.dart';
import 'package:e_waste/app/widgets/ui_factory/ui_factory.dart';
import 'package:e_waste/app_localizations.dart';
import 'package:e_waste/domain/repositories/analytics_service.dart';
import 'package:e_waste/domain/repositories/app_configuration_repository.dart';
import 'package:e_waste/domain/repositories/info_repository.dart';
import 'package:e_waste/domain/repositories/news_repository.dart';
import 'package:e_waste/domain/repositories/objects_from_api_repository.dart';
import 'package:e_waste/domain/repositories/url_opener.dart';
import 'package:flutter/material.dart';

import 'app_configuration_controller.dart';

class Root extends StatefulWidget {
  final AnalyticsService analyticsService;
  final AppConfigurationRepository appConfigurationRepository;
  final ObjectsFromApiRepository objectsFromApiRepository;
  final InfoRepository infoRepository;
  final NewsRepository newsRepository;
  final UrlOpener urlOpener;

  const Root(
      {Key key,
      this.analyticsService,
      this.appConfigurationRepository,
      this.objectsFromApiRepository,
      this.infoRepository,
      this.newsRepository,
      this.urlOpener})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RootState(
        analyticsService,
        AppConfigurationController(appConfigurationRepository),
        objectsFromApiRepository,
        infoRepository,
        newsRepository,
        urlOpener);
  }
}

class _RootState extends State<Root> {
  final AnalyticsService _analyticsService;
  final AppConfigurationController _appConfigurationController;
  final ObjectsFromApiRepository _objectsFromApiRepository;
  final InfoRepository _infoRepository;
  final NewsRepository _newsRepository;
  final UrlOpener _urlOpener;
  final GlobalKey<State<StatefulWidget>> globalKey =
      GlobalKey<State<StatefulWidget>>();

  _RootState(
      this._analyticsService,
      this._appConfigurationController,
      this._objectsFromApiRepository,
      this._infoRepository,
      this._newsRepository,
      this._urlOpener) {
    _children = [
      HomePage(_objectsFromApiRepository),
      NewsPage(_newsRepository, _urlOpener),
      AboutPage(_analyticsService, _infoRepository)
    ];
    _appConfigurationController.showUpgradeDialog = _showUpgradeDialog;
  }

  int _currentIndex = 0;
  List<Widget> _children = [];

  @override
  Widget build(BuildContext context) {
    _appConfigurationController.context = context;
    return _appScaffold();
  }

  Widget _appScaffold() => Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate("ewaste_name"),
          style: TextStyle(fontFamily: EWasteLayout.HEADER_FONT),
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: UIFactory.createBottomTabBar(
          _currentIndex,
          [
            Item(AppLocalizations.of(context).translate("map"),
                new Icon(Icons.map),
                activeColor: Colors.redAccent),
            Item(AppLocalizations.of(context).translate("newsfeed"),
                new Icon(Icons.speaker_notes),
                activeColor: Colors.blueAccent),
            Item(AppLocalizations.of(context).translate("info"),
                new Icon(Icons.info))
          ],
          _onTabTapped));

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _showUpgradeDialog(bool shouldShow) {
    if (shouldShow) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => CustomDialog(
          title: AppLocalizations.of(context).translate("must_update"),
          description:
              AppLocalizations.of(context).translate("update_required"),
          icon: Icon(Icons.update),
          actions: [
            DialogAction(
                AppLocalizations.of(context).translate("positive_button"),
                _navigateToStore)
          ],
        ),
      );
    }
  }

  _navigateToStore() {
    OutsideActionsManager().navigateToStore();
  }
}

class BlurryEffect extends StatelessWidget {
  final double opacity;
  final double blurry;
  final Color shade;

  BlurryEffect(this.opacity, this.blurry, this.shade);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurry, sigmaY: blurry),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: shade.withOpacity(opacity)),
          ),
        ),
      ),
    );
  }
}
