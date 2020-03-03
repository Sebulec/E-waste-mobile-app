import 'package:e_waste/domain/entities/all_objects.dart';
import 'package:e_waste/domain/entities/location.dart';

abstract class ObjectsFromApiRepository {
  Future<AllObjects> getAllObjectsForLocation(Location location, double range);
}
