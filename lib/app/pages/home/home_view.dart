import 'dart:async';

import 'package:e_waste/app/widgets/constants.dart';
import 'package:e_waste/app/widgets/custom_dialog.dart';
import 'package:e_waste/app_localizations.dart';
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
  bool _shouldShowMap = false;

  _HomePageState() : super(HomeController(DataObjectsFromApiRepository())) {
    controller.didSetLocation(Location(_initialCameraPosition.target.latitude,
        _initialCameraPosition.target.longitude));
    controller.getAllObjects();
    checkLocationPermissionAndDisplayDialogIfPermitted();
  }

  void checkLocationPermissionAndDisplayDialogIfPermitted() async {
    bool isLocationEnabled = await location.Location().serviceEnabled();
    if (!isLocationEnabled) {
      _showPermissionDialog();
    } else {
      _shouldShowMap = true;
      setState(() {});
    }
  }

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _googleMapController;

  CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(52.228821, 21.007953),
    zoom: EWasteLayout.CAMERA_ZOOM,
  );

  @override
  Widget buildPage() {
    return _shouldShowMap ? _buildGoogleMap() : _showLoader();
  }

  _buildGoogleMap() => GoogleMap(
      key: globalKey,
      mapType: MapType.normal,
      markers: Set.from(controller.allObjects),
      initialCameraPosition: _initialCameraPosition,
      onMapCreated: _onMapCreated,
      onCameraIdle: () => _cameraDidStopped(),
      myLocationEnabled: true);

  _showLoader() => Container(
      child: Center(child: CircularProgressIndicator()), color: Colors.white);

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

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: AppLocalizations.of(context).translate("ewaste_name"),
        description:
            AppLocalizations.of(context).translate("location_required"),
        actions: [
          DialogAction(
              AppLocalizations.of(context).translate("positive_button"),
              () => print("did press "))
        ],
      ),
    );
  }
}
