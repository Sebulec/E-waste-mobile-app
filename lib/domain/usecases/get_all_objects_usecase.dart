import 'dart:async';

import 'package:e_waste/domain/entities/all_objects.dart';
import 'package:e_waste/domain/entities/location.dart';
import 'package:e_waste/domain/entities/object_type.dart';
import 'package:e_waste/domain/entities/waste_type.dart';
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
          .getAllObjectsForLocation(params.location, params.range);
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      _setWasteTypesForShops(allObjects);
      _setObjectTypes(allObjects);
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

  void _setWasteTypesForShops(AllObjects allObjects) {
    allObjects.shops.forEach((shop) {
      shop.wasteTypes = [
        WasteType(
            "Energy efficient bubbles", WasteTypeEnum.energyEfficientBulbs),
        WasteType("Small electronics", WasteTypeEnum.smallElectronics),
        WasteType("Batteries", WasteTypeEnum.batteries)
      ];
    });
  }

  void _setObjectTypes(AllObjects allObjects) {
    allObjects.custom
        .forEach((object) => object.objectType = ObjectType.custom);
    allObjects.shops.forEach((object) => object.objectType = ObjectType.shop);
  }
}

class GetAllObjectsUseCaseResponse {
  final AllObjects allObjects;

  GetAllObjectsUseCaseResponse(this.allObjects);
}

class GetAllObjectsUseCaseParams {
  final Location location;
  final double range;

  GetAllObjectsUseCaseParams(this.location, this.range);
}
