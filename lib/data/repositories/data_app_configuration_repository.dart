import 'package:e_waste/domain/entities/app_configuration.dart';
import 'package:e_waste/domain/repositories/app_configuration_repository.dart';

class DataAppConfigurationRepository extends AppConfigurationRepository {
  AppConfiguration appConfiguration = AppConfiguration(1, 1);

  // sigleton
  static DataAppConfigurationRepository _instance =
      DataAppConfigurationRepository._internal();

  DataAppConfigurationRepository._internal();

  @override
  Future<AppConfiguration> getAppConfiguration() async {
    return appConfiguration;
  }

  factory DataAppConfigurationRepository() => _instance;
}
