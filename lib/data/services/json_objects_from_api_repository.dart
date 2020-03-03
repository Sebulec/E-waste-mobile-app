import 'package:e_waste/domain/entities/all_objects.dart';
import 'package:e_waste/domain/entities/location.dart';
import 'package:e_waste/domain/repositories/objects_from_api_repository.dart';

import 'core/api_base.dart';
import 'json_number_formatter.dart';

class JsonObjectsFromApiRepository extends ObjectsFromApiRepository {
  final ApiBase _apiBase;
  final String _getAllObjects = "places";

  JsonObjectsFromApiRepository(this._apiBase);

  @override
  Future<AllObjects> getAllObjectsForLocation(
      Location location, double range) async {
    final response = await _apiBase.get(_getAllObjects +
        _LocationWrapper(location, range).getLocationForRequest());
    return AllObjects.fromJson(response);
  }
}

class _LocationWrapper {
  final Location _location;
  final double _range;

  _LocationWrapper(this._location, this._range);

  String getLocationForRequest() {
    return "?lat=${JsonNumberFormatter(_location.latitude).getFormattedValue()}&long=${JsonNumberFormatter(_location.longitude).getFormattedValue()}&range=${JsonNumberFormatter(_range).getAsInteger()}";
  }
}
