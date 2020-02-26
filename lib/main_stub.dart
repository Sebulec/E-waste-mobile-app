import 'package:e_waste/app.dart';
import 'package:e_waste/data/repositories/data_app_configuration_repository.dart';
import 'package:e_waste/data/repositories/data_info_repository.dart';
import 'package:e_waste/data/repositories/data_objects_from_api_repository.dart';
import 'package:e_waste/data/services/analytics_service_impl.dart';
import 'package:e_waste/domain/repositories/analytics_service.dart';
import 'package:e_waste/domain/repositories/info_repository.dart';
import 'package:e_waste/domain/repositories/objects_from_api_repository.dart';
import 'package:flutter/material.dart';
import 'domain/repositories/app_configuration_repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final AnalyticsService _analyticsService = AnalyticsServiceImpl();
  final AppConfigurationRepository _appConfigurationRepository =
      DataAppConfigurationRepository();
  final ObjectsFromApiRepository _objectsFromApiRepository =
      DataObjectsFromApiRepository();
  final InfoRepository _infoRepository = DataInfoRepository();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return App(_analyticsService, _appConfigurationRepository,
        _objectsFromApiRepository, _infoRepository);
  }
}
