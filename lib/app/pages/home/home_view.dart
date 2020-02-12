import 'dart:async';

import 'package:e_waste/app/widgets/constants.dart';
import 'package:e_waste/app/widgets/custom_dialog.dart';
import 'package:e_waste/data/repositories/data_objects_from_api_repository.dart';
import 'package:e_waste/domain/entities/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;

import 'home_controller.dart';

class HomePage extends View {
  @override
  _HomePageState createState() =>
      // inject dependencies inwards
      _HomePageState();
}

class _HomePageState extends ViewState<HomePage, HomeController> {
  _HomePageState() : super(HomeController(DataObjectsFromApiRepository())) {
    controller.getAllObjects();
    _controller.future.whenComplete(_didLoadController);
  }

  void _didLoadController() async {
    print("Did finished loading google map controller");
    // check the permission
    // show dialog

    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Success",
        description: "We need your localization 😈",
        buttonText: "Okay",
      ),
    );

    // location.LocationData currentLocation =
    //     await location.Location.getLocation();
  }

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _googleMapController;

  CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(52.228821, 21.007953),
    zoom: EWasteLayout.CAMERA_ZOOM,
  );

  @override
  Widget buildPage() {
    return GoogleMap(
        key: globalKey,
        mapType: MapType.normal,
        markers: Set.from(controller.allObjects),
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: _onMapCreated,
        onCameraIdle: () => _cameraDidStopped(),
        myLocationEnabled: true);
  }

  void _onMapCreated(GoogleMapController googleMapController) {
    _googleMapController = googleMapController;
    _controller.complete(googleMapController);
  }

  void _cameraDidStopped() async {
    LatLngBounds currentLocationBounds =
        await _googleMapController?.getVisibleRegion();

    if (currentLocationBounds.northeast != null) {
      controller.didSetLocation(Location(
          currentLocationBounds.northeast.latitude,
          currentLocationBounds.northeast.longitude));
    }
  }
}
