import 'package:e_waste/data/services/analytics_service_impl.dart';
import 'package:e_waste/data/services/core/api_base.dart';
import 'package:e_waste/data/services/core/api_base_helper.dart';
import 'package:e_waste/data/services/json_info_repository.dart';
import 'package:e_waste/domain/repositories/analytics_service.dart';
import 'package:e_waste/domain/repositories/info_repository.dart';
import 'package:e_waste/domain/repositories/objects_from_api_repository.dart';
import 'package:flutter/material.dart';
import 'data/services/json_app_configuration_repostiory.dart';
import 'data/services/json_objects_from_api_repository.dart';
import 'domain/repositories/app_configuration_repository.dart';
import 'my_app.dart';

final ApiBase _apiBase = ApiBaseHelper();
final AppConfigurationRepository _appConfigurationRepository =
    JsonAppConfigurationRepository(_apiBase);
final ObjectsFromApiRepository _objectsFromApiRepository =
    JsonObjectsFromApiRepository(_apiBase);
final InfoRepository _infoRepository = JsonInfoRepository(_apiBase);
final AnalyticsService _analyticsService = AnalyticsServiceImpl();
final myApp = MyApp(
  analyticsService: _analyticsService,
  objectsFromApiRepository: _objectsFromApiRepository,
  infoRepository: _infoRepository,
  appConfigurationRepository: _appConfigurationRepository,
);

void main() => runApp(myApp);
