import 'package:e_waste/app_localizations.dart';
import 'package:e_waste/domain/entities/all_objects.dart';
import 'package:e_waste/domain/entities/object_from_api.dart';
import 'package:e_waste/domain/entities/object_type.dart';
import 'package:e_waste/domain/entities/waste_type.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class ObjectTappedObserver {
  void didTapObject(ObjectFromApi objectFromApi);
}

class AllObjectsFromApiToMarkerWrapper {
  final AllObjects _allObjects;
  final ObjectTappedObserver _objectTappedObserver;

  AllObjectsFromApiToMarkerWrapper(
      this._allObjects, this._objectTappedObserver);

  List<Marker> getAllObjectsAsMarkers(BuildContext context) {
    return _allObjects != null
        ? [_allObjects.custom, _allObjects.shops]
            .expand((el) => el)
            .map((object) => ObjectFromApiToMarkerWrapper(object, context)
                .getMarker(() => _objectTappedObserver.didTapObject(object)))
            .toList()
        : [];
  }
}

class ObjectFromApiToMarkerWrapper {
  final ObjectFromApi _objectFromApi;
  final BuildContext context;

  ObjectFromApiToMarkerWrapper(this._objectFromApi, this.context);

  Marker getMarker(Function onTap) => Marker(
      markerId: MarkerId(_objectFromApi.googlePlaceId),
      position: LatLng(_objectFromApi.lat, _objectFromApi.long),
      icon: ObjectTypeBitmapDecorator.getBitMapDescriptionForObjectType(
          _objectFromApi.objectType),
      infoWindow: _ObjectFromApiToInfoWindowWrapper(_objectFromApi, context)
          .getInfoWindow(onTap));
}

class _ObjectFromApiToInfoWindowWrapper {
  final ObjectFromApi _objectFromApi;
  final BuildContext context;

  _ObjectFromApiToInfoWindowWrapper(this._objectFromApi, this.context);

  InfoWindow getInfoWindow(Function onTap) => InfoWindow(
      title: "${_objectFromApi.name}",
      snippet: ObjectFromApiDetailInfo(_objectFromApi, context).toString(),
      onTap: () => onTap);
}

class ObjectFromApiDetailInfo {
  final ObjectFromApi _objectFromApi;
  final BuildContext context;

  ObjectFromApiDetailInfo(this._objectFromApi, this.context);

  @override
  String toString() {
    AppLocalizations localizations = AppLocalizations.of(context);
    String youHaveMessage = localizations.translate("you_can_leave");
    String listOfAvailableWasteTypesMessage = ": ";
    List<String> wasteTypeLocalized = _objectFromApi.wasteTypes
        .map((wasteType) => localizations
            .translate(WasteTypeEnumLocalized(wasteType.type).localized()))
        .toList();
    wasteTypeLocalized.forEach((localizedWasteType) {
      listOfAvailableWasteTypesMessage += "$localizedWasteType, ";
    });
    return "${_objectFromApi.address}\n$youHaveMessage${listOfAvailableWasteTypesMessage.substring(0, listOfAvailableWasteTypesMessage.length - 2)}.";
  }
}
