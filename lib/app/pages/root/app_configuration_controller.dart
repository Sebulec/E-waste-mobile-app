import 'package:e_waste/domain/entities/app_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:package_info/package_info.dart';
import 'dart:io' show Platform;

import 'app_configuration_presenter.dart';

class AppConfigurationController extends Controller {
  final AppConfigurationPresenter appConfigurationPresenter;
  AppConfiguration _appConfiguration;

  AppConfigurationController(appConfigurationRepo)
      : appConfigurationPresenter =
            AppConfigurationPresenter(appConfigurationRepo);

  Function showUpgradeDialog;

  @override
  void initListeners() {
    appConfigurationPresenter.getAppConfigurationOnNext =
        (AppConfiguration appConfiguration) {
      _appConfiguration = appConfiguration;
      refreshUI(); // Refreshes the UI manually
    };
    appConfigurationPresenter.getAppConfigurationOnComplete = () {
      print('All objects retrieved');
    };

    // On error, show a snackbar, remove the user, and refresh the UI
    appConfigurationPresenter.getAppConfigurationOnError = (e) {
      print('Could not retrieve app configuration.');
      ScaffoldState state = getState();
      state.showSnackBar(SnackBar(content: Text(e.message)));
      _appConfiguration = null;
      refreshUI(); // Refreshes the UI manually
    };
  }

  void checkAppVersionAndDecideToShowUpdateDialog() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.tryParse(packageInfo.buildNumber) ?? 1;
    _compareVersion(_appConfiguration, buildNumber);
  }

  _compareVersion(AppConfiguration appConfiguration, int buildNumber) {
    if (Platform.isAndroid) {
      print("android");
    } else if (Platform.isIOS) {
      print("ios");
    }
    showUpgradeDialog(true);
  }
}
