import 'package:e_waste/app/pages/home/home_view.dart';
import 'package:e_waste/app_localizations.dart';
import 'package:flutter/material.dart';

class Root extends StatefulWidget {
  const Root({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RootState();
  }
}

class _RootState extends State<Root> {
  int _currentIndex = 0;
  final List<Widget> _children = [HomePage(), HomePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("ewaste_name")),
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
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
