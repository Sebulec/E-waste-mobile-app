import 'dart:async';
import 'package:e_waste/app/widgets/analytics_screen.dart';
import 'package:e_waste/app/widgets/constants.dart';
import 'package:e_waste/data/services/analytics_service_impl.dart';
import 'package:e_waste/domain/entities/location.dart';
import 'package:e_waste/domain/repositories/objects_from_api_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'home_controller.dart';

class HomePage extends View {
  final ObjectsFromApiRepository objectsFromApiRepository;

  HomePage(this.objectsFromApiRepository);

  @override
  _HomePageState createState() =>
      // inject dependencies inwards
      _HomePageState(this.objectsFromApiRepository);
}

class _HomePageState extends ViewState<HomePage, HomeController>
    with AnalyticsScreen {
  bool _shouldShowMap = false;
  String _mapStyle;

  @override
  String get screenName => ScreenName.MAP_NAME;

  _HomePageState(ObjectsFromApiRepository objectsFromApiRepository)
      : super(HomeController(objectsFromApiRepository)) {
    checkLocationPermissionAndDisplayDialogIfPermitted();
    setCurrentScreen();
    rootBundle.loadString(Resources.mapStyleLocation).then((string) {
      _mapStyle = string;
    });
  }

  void checkLocationPermissionAndDisplayDialogIfPermitted() async {
    bool isLocationEnabled = await location.Location().serviceEnabled();
    if (isLocationEnabled) {
      location.Location().getLocation().then((location) {
        _initialCameraPosition = CameraPosition(
          target: LatLng(location.latitude, location.longitude),
          zoom: EWasteLayout.CAMERA_ZOOM,
        );
        _shouldShowMap = true;
        setState(() {});
      });
    }
  }

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _googleMapController;
  CameraPosition _initialCameraPosition;

  @override
  Widget buildPage() {
    controller.context = context;
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
    _googleMapController.setMapStyle(_mapStyle);
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
