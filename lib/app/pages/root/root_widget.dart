import 'dart:ui';

import 'package:e_waste/app/pages/about/about_view.dart';
import 'package:e_waste/app/pages/home/home_view.dart';
import 'package:e_waste/app/pages/root/outside_actions_manager.dart';
import 'package:e_waste/app/widgets/constants.dart';
import 'package:e_waste/app/widgets/custom_dialog.dart';
import 'package:e_waste/app_localizations.dart';
import 'package:e_waste/domain/repositories/analytics_service.dart';
import 'package:e_waste/domain/repositories/app_configuration_repository.dart';
import 'package:e_waste/domain/repositories/objects_from_api_repository.dart';
import 'package:flutter/material.dart';

import 'app_configuration_controller.dart';

class Root extends StatefulWidget {
  final AnalyticsService analyticsService;
  final AppConfigurationRepository appConfigurationRepository;
  final ObjectsFromApiRepository objectsFromApiRepository;

  const Root(
      {Key key,
      this.analyticsService,
      this.appConfigurationRepository,
      this.objectsFromApiRepository})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RootState(
        analyticsService,
        AppConfigurationController(appConfigurationRepository),
        objectsFromApiRepository);
  }
}

class _RootState extends State<Root> {
  final AnalyticsService _analyticsService;
  final AppConfigurationController _appConfigurationController;
  final ObjectsFromApiRepository _objectsFromApiRepository;

  _RootState(this._analyticsService, this._appConfigurationController,
      this._objectsFromApiRepository) {
    _children = [
      HomePage(_objectsFromApiRepository),
      AboutPage(_analyticsService)
    ];
    _appConfigurationController.showUpgradeDialog = _showUpgradeDialog;
  }

  int _currentIndex = 0;
  List<Widget> _children = [];

  @override
  Widget build(BuildContext context) {
    return _appScaffold();
  }

  Widget _appScaffold() => Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).translate("ewaste_name"),
            style: TextStyle(fontFamily: EWasteLayout.HEADER_FONT),
          ),
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.map),
              title: new Text(AppLocalizations.of(context).translate("map")),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.info),
              title: new Text(AppLocalizations.of(context).translate("info")),
            )
          ],
        ),
      );

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
