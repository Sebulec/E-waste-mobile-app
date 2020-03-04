import 'package:e_waste/data/repositories/data_app_configuration_repository.dart';
import 'package:e_waste/data/repositories/data_info_repository.dart';
import 'package:e_waste/data/repositories/data_objects_from_api_repository.dart';
import 'package:e_waste/domain/repositories/analytics_service.dart';
import 'package:e_waste/domain/repositories/info_repository.dart';
import 'package:e_waste/domain/repositories/objects_from_api_repository.dart';
import 'package:flutter/material.dart';
import 'data/repositories/analytics_service_stub.dart';
import 'domain/repositories/app_configuration_repository.dart';
import 'my_app.dart';

final AppConfigurationRepository _appConfigurationRepository =
    DataAppConfigurationRepository();
final ObjectsFromApiRepository _objectsFromApiRepository =
    DataObjectsFromApiRepository();
final InfoRepository _infoRepository = DataInfoRepository();
final AnalyticsService _analyticsService = AnalyticsServiceStub();
final myApp = MyApp(
  analyticsService: _analyticsService,
  objectsFromApiRepository: _objectsFromApiRepository,
  infoRepository: _infoRepository,
  appConfigurationRepository: _appConfigurationRepository,
);

void main() => runApp(myApp);
