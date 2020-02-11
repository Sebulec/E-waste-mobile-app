import 'package:e_waste/app/widgets/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum ObjectType { custom, shop }

class ObjectTypeImageName {
  static String getImageNameForObjectType(ObjectType objectType) {
    switch (objectType) {
      case ObjectType.custom:
        return EWasteImage.customLogo;
      case ObjectType.shop:
        return EWasteImage.biedronkaLogo;
    }
    return null;
  }
}

class ObjectTypeBitmapDecorator {
  static BitmapDescriptor getBitMapDescriptionForObjectType(
      ObjectType objectType) {
    switch (objectType) {
      case ObjectType.custom:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
      case ObjectType.shop:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }
    return null;
  }
}
