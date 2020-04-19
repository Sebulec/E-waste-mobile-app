import 'package:e_waste/app/pages/root/root_widget.dart';
import 'package:e_waste/app/widgets/constants.dart';
import 'package:e_waste/app_localizations.dart';
import 'package:e_waste/domain/repositories/analytics_service.dart';
import 'package:e_waste/domain/repositories/app_configuration_repository.dart';
import 'package:e_waste/domain/repositories/info_repository.dart';
import 'package:e_waste/domain/repositories/objects_from_api_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends MaterialApp {
  App(
      AnalyticsService analyticsService,
      AppConfigurationRepository appConfigurationRepository,
      ObjectsFromApiRepository objectsFromApiRepository,
      InfoRepository infoRepository)
      : super(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              AppLocalizations.delegate,
            ],
            supportedLocales: [Locale('en', 'US'), Locale('pl', 'PL')],
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
            navigatorObservers: [analyticsService.getAnalyticsObserver()],
            theme: ThemeData(
                accentColor: EWasteLayout.ACCENT_COLOR,
                primarySwatch: EWasteLayout.PRIMARY_COLOR,
                fontFamily: EWasteLayout.REGULAR_FONT),
            home: Root(
                analyticsService: analyticsService,
                appConfigurationRepository: appConfigurationRepository,
                objectsFromApiRepository: objectsFromApiRepository,
                infoRepository: infoRepository)) {
    FlutterCleanArchitecture.debugModeOn();
  }
}
