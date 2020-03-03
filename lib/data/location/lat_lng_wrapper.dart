import 'package:e_waste/domain/entities/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LatLngWrapper extends Location {
  LatLngWrapper(LatLng latLng) : super(latLng.latitude, latLng.longitude);
}
