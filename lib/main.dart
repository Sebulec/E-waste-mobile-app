import 'package:e_waste/data/repositories/data_app_configuration_repository.dart';
import 'package:e_waste/data/services/analytics_service_impl.dart';
import 'package:e_waste/domain/repositories/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'app/pages/root/root_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/widgets/constants.dart';
import 'app_localizations.dart';
import 'domain/repositories/app_configuration_repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final AnalyticsService _analyticsService = AnalyticsServiceImpl();
  final AppConfigurationRepository _appConfigurationRepository = DataAppConfigurationRepository();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var supportedLocales = [Locale('en', 'US'), Locale('pl', 'PL')];
    FlutterCleanArchitecture.debugModeOn();
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          AppLocalizations.delegate,
        ],
        supportedLocales: supportedLocales,
        debugShowCheckedModeBanner: false,
        // Returns a locale which will be used by the app
        localeResolutionCallback: (locale, supportedLocales) {
          if (locale == null) {
            debugPrint("*language locale is null!!!");
            return supportedLocales.first;
          }

          for (Locale supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode ||
                supportedLocale.countryCode == locale.countryCode) {
              debugPrint("*language ok $supportedLocale");
              return supportedLocale;
            }
          }

          debugPrint("*language to fallback ${supportedLocales.first}");
          return supportedLocales.first;
        },
        navigatorObservers: [_analyticsService.getAnalyticsObserver()],
        theme: ThemeData(
            primarySwatch: Colors.blue, fontFamily: EWasteLayout.REGULAR_FONT),
        home: Root(
          analyticsService: _analyticsService,
          appConfigurationRepository: _appConfigurationRepository,
        ));
  }
}
