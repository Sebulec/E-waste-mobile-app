import 'package:e_waste/domain/entities/app_configuration.dart';

abstract class AppConfigurationRepository {
  final appConfigurationId = 1;
  Future<AppConfiguration> getAppConfiguration();
}