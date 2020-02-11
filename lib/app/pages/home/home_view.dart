import 'dart:async';

import 'package:e_waste/data/repositories/data_objects_from_api_repository.dart';
import 'package:e_waste/domain/entities/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'home_controller.dart';

class HomePage extends View {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() =>
      // inject dependencies inwards
      _HomePageState();
}

class _HomePageState extends ViewState<HomePage, HomeController> {
  _HomePageState() : super(HomeController(DataObjectsFromApiRepository())) {
    controller.getAllObjects();
  }

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _googleMapController;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget buildPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Scaffold(
        key:
            globalKey, // built in global key for the ViewState for easy access in the controller
        body: GoogleMap(
            mapType: MapType.hybrid,
            markers: Set.from(controller.allObjects),
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _googleMapController = controller;
              _controller.complete(controller);
            },
            onCameraIdle: () async {
              LatLngBounds currentLocationBounds =
                  await _googleMapController?.getVisibleRegion();

              if (currentLocationBounds.northeast != null) {
                controller.didSetLocation(Location(
                    currentLocationBounds.northeast.latitude,
                    currentLocationBounds.northeast.longitude));
              }
            },
            myLocationEnabled: true),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.mail),
              title: new Text('Messages'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text('Profile'))
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // void getMarkers() async {
  //   // BitmapDescriptor image = await BitmapDescriptor.fromAssetImage(
  //   // ImageConfiguration(devicePixelRatio: 5.0), 'images/biedronka-logo.png');
  //   BitmapDescriptor image =
  //       BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
  //   markers = Set.from([]);

  //   for (int i = 0; i < 20; i++) {
  //     var marker = Marker(
  //         position: LatLng(51.1459711, 16.8583618),
  //         markerId: MarkerId("$i"),
  //         infoWindow: InfoWindow(title: "snipper"),
  //         icon: image);
  //     markers.add(marker);
  //   }
  //   setState(() {});
  // }

  // Future<void> _goToTheLake() async {
  //   LocationData currentLocation;

  //   var location = new Location();
  //   var error;
  //   try {
  //     currentLocation = await location.getLocation();
  //   } catch (e) {
  //     if (e.code == 'PERMISSION_DENIED') {
  //       error = 'Permission denied';
  //     }
  //     currentLocation = null;
  //   }

  //   var locationForCamera = CameraPosition(
  //     target: LatLng(currentLocation.latitude, currentLocation.longitude),
  //     zoom: EWasteLayout.CAMERA_ZOOM,
  //   );

  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(locationForCamera));
  // }
}
