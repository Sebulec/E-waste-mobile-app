import 'dart:async';

import 'package:e_waste/domain/entities/app_configuration.dart';
import 'package:e_waste/domain/repositories/app_configuration_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetAppConfigurationUseCase extends UseCase<
    GetAppConfigurationUseCaseResponse, GetAppConfigurationUseCaseParams> {
  final AppConfigurationRepository _appConfigurationRepository;
  GetAppConfigurationUseCase(this._appConfigurationRepository);

  @override
  Future<Stream<GetAppConfigurationUseCaseResponse>> buildUseCaseStream(
      GetAppConfigurationUseCaseParams params) async {
    final StreamController<GetAppConfigurationUseCaseResponse> controller =
        StreamController();
    try {
      // get app configuration
      AppConfiguration appConfiguration =
          await _appConfigurationRepository.getAppConfiguration();
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(GetAppConfigurationUseCaseResponse(appConfiguration));
      logger.finest('GetAppConfigurationUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetAppConfigurationUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetAppConfigurationUseCaseResponse {
  final AppConfiguration appConfiguration;

  GetAppConfigurationUseCaseResponse(this.appConfiguration);
}

class GetAppConfigurationUseCaseParams {
  final int appConfigurationId;

  GetAppConfigurationUseCaseParams(this.appConfigurationId);
}
