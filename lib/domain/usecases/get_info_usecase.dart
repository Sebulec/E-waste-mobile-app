import 'dart:async';

import 'package:e_waste/domain/entities/info.dart';
import 'package:e_waste/domain/repositories/info_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetInfoUseCase
    extends UseCase<GetInfoUseCaseResponse, GetInfoUseCaseParams> {
  final InfoRepository _infoRepository;
  GetInfoUseCase(this._infoRepository);

  @override
  Future<Stream<GetInfoUseCaseResponse>> buildUseCaseStream(
      GetInfoUseCaseParams params) async {
    final StreamController<GetInfoUseCaseResponse> controller =
        StreamController();
    try {
      // get info
      Info info = await _infoRepository.getInfo(params.countryCode);
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(GetInfoUseCaseResponse(info));
      logger.finest('GetInfoUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetInfoUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetInfoUseCaseResponse {
  final Info info;

  GetInfoUseCaseResponse(this.info);
}

class GetInfoUseCaseParams {
  final String countryCode;

  GetInfoUseCaseParams(this.countryCode);
}
