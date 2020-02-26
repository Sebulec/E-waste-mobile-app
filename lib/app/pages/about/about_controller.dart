import 'package:e_waste/app_localizations.dart';
import 'package:e_waste/domain/entities/info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'about_presenter.dart';

class AboutController extends Controller {
  final AboutPresenter aboutPresenter;
  Info _info;
  String _currentCountryCode;
  BuildContext context;

  // Presenter should always be initialized this way
  AboutController(infoRepo)
      : aboutPresenter = AboutPresenter(infoRepo),
        super();

  @override
  void initListeners() async {
    aboutPresenter.getInfoOnNext = (Info info) {
      _info = info;
      refreshUI(); // Refreshes the UI manually
    };
    aboutPresenter.getInfoOnComplete = () {
      print('All objects retrieved');
    };

    // On error, show a snackbar, remove the user, and refresh the UI
    aboutPresenter.getInfoOnError = (e) {
      print('Could not retrieve all objects.');
      ScaffoldState state = Scaffold.of(context);
      state.showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context).translate(e.toString()))));
      _info = null;
      refreshUI(); // Refreshes the UI manually
    };
  }

  Info get info => _info;

  void setCountryCode(String countryCode) {
    _currentCountryCode = countryCode;
  }

  getInfo() => aboutPresenter.getInfo(_currentCountryCode ?? "EN");
}
