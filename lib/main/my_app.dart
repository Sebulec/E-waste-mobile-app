import 'package:e_waste/domain/repositories/analytics_service.dart';
import 'package:e_waste/domain/repositories/app_configuration_repository.dart';
import 'package:e_waste/domain/repositories/info_repository.dart';
import 'package:e_waste/domain/repositories/news_repository.dart';
import 'package:e_waste/domain/repositories/objects_from_api_repository.dart';
import 'package:flutter/widgets.dart';

import 'app.dart';

class MyApp extends StatelessWidget {
  final AnalyticsService analyticsService;
  final AppConfigurationRepository appConfigurationRepository;
  final ObjectsFromApiRepository objectsFromApiRepository;
  final InfoRepository infoRepository;
  final NewsRepository newsRepository;

  const MyApp(
      {Key key,
      this.analyticsService,
      this.appConfigurationRepository,
      this.objectsFromApiRepository,
      this.infoRepository,
      this.newsRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return App(analyticsService, appConfigurationRepository,
        objectsFromApiRepository, infoRepository, newsRepository);
  }
}
