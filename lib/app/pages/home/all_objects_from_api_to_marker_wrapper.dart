import 'package:e_waste/domain/entities/all_objects.dart';
import 'package:e_waste/domain/entities/object_from_api.dart';
import 'package:e_waste/domain/entities/object_type.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class ObjectTappedObserver {
  void didTapObject(ObjectFromApi objectFromApi);
}

class AllObjectsFromApiToMarkerWrapper {
  final AllObjects _allObjects;
  final ObjectTappedObserver _objectTappedObserver;

  AllObjectsFromApiToMarkerWrapper(
      this._allObjects, this._objectTappedObserver);

  List<Marker> getAllObjectsAsMarkers() {
    return _allObjects != null
        ? [_allObjects.custom, _allObjects.shops]
            .expand((el) => el)
            .map((object) => ObjectFromApiToMarkerWrapper(object)
                .getMarker(() => _objectTappedObserver.didTapObject(object)))
            .toList()
        : [];
  }
}

class ObjectFromApiToMarkerWrapper {
  final ObjectFromApi _objectFromApi;

  ObjectFromApiToMarkerWrapper(this._objectFromApi);

  Marker getMarker(Function onTap) => Marker(
      markerId: MarkerId(_objectFromApi.googlePlaceId),
      position: LatLng(_objectFromApi.lat, _objectFromApi.long),
      icon: ObjectTypeBitmapDecorator.getBitMapDescriptionForObjectType(
          _objectFromApi.objectType),
      infoWindow: _ObjectFromApiToInfoWindowWrapper(_objectFromApi)
          .getInfoWindow(onTap));
}

class _ObjectFromApiToInfoWindowWrapper {
  final ObjectFromApi _objectFromApi;

  _ObjectFromApiToInfoWindowWrapper(this._objectFromApi);

  InfoWindow getInfoWindow(Function onTap) =>
      InfoWindow(title: _objectFromApi.name, onTap: () => onTap);
}
