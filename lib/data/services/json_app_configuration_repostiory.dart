import 'package:e_waste/domain/entities/app_configuration.dart';
import 'package:e_waste/domain/repositories/app_configuration_repository.dart';

import 'core/api_base.dart';

class JsonAppConfigurationRepository extends AppConfigurationRepository {
  final ApiBase _apiBase;
  final String _getAppConfiguration = "app-configurations/1";

  JsonAppConfigurationRepository(this._apiBase);

  @override
  Future<AppConfiguration> getAppConfiguration() async {
    final response = await _apiBase.get(_getAppConfiguration);
    return AppConfiguration.fromJson(response);
  }
}
