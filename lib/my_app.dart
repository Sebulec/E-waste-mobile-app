import 'package:flutter/widgets.dart';

import 'app.dart';
import 'domain/repositories/analytics_service.dart';
import 'domain/repositories/app_configuration_repository.dart';
import 'domain/repositories/info_repository.dart';
import 'domain/repositories/objects_from_api_repository.dart';

class MyApp extends StatelessWidget {
  final AnalyticsService analyticsService;
  final AppConfigurationRepository appConfigurationRepository;
  final ObjectsFromApiRepository objectsFromApiRepository;
  final InfoRepository infoRepository;

  const MyApp(
      {Key key,
      this.analyticsService,
      this.appConfigurationRepository,
      this.objectsFromApiRepository,
      this.infoRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return App(analyticsService, appConfigurationRepository,
        objectsFromApiRepository, infoRepository);
  }
}
