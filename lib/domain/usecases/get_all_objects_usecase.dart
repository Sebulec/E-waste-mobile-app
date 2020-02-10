import 'dart:async';

import 'package:e_waste/domain/entities/all_objects.dart';
import 'package:e_waste/domain/entities/location.dart';
import 'package:e_waste/domain/repositories/objects_from_api_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetAllObjectsUseCase
    extends UseCase<GetAllObjectsUseCaseResponse, GetAllObjectsUseCaseParams> {
  final ObjectsFromApiRepository _objectsFromApiRepository;
  GetAllObjectsUseCase(this._objectsFromApiRepository);

  @override
  Future<Stream<GetAllObjectsUseCaseResponse>> buildUseCaseStream(
      GetAllObjectsUseCaseParams params) async {
    final StreamController<GetAllObjectsUseCaseResponse> controller =
        StreamController();
    try {
      // get allObjects
      AllObjects allObjects = await _objectsFromApiRepository
          .getAllObjectsForLocation(params.location);
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(GetAllObjectsUseCaseResponse(allObjects));
      logger.finest('GetAllObjectsUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetAllObjectsUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetAllObjectsUseCaseResponse {
  final AllObjects allObjects;

  GetAllObjectsUseCaseResponse(this.allObjects);
}

class GetAllObjectsUseCaseParams {
  final Location location;

  GetAllObjectsUseCaseParams(this.location);
}
