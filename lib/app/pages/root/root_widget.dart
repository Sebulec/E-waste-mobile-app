import 'dart:ui';

import 'package:e_waste/app/pages/about/about_view.dart';
import 'package:e_waste/app/pages/home/home_view.dart';
import 'package:e_waste/app/widgets/constants.dart';
import 'package:e_waste/app_localizations.dart';
import 'package:e_waste/domain/repositories/analytics_service.dart';
import 'package:flutter/material.dart';

class Root extends StatefulWidget {
  final AnalyticsService analyticsService;
  const Root({Key key, this.analyticsService}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RootState(analyticsService);
  }
}

class _RootState extends State<Root> {
  final AnalyticsService _analyticsService;

  _RootState(this._analyticsService) {
    _children = [HomePage(), AboutPage(_analyticsService)];
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
