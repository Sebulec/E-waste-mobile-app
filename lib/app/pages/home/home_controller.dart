import 'dart:async';

import 'package:e_waste/app_localizations.dart';
import 'package:e_waste/data/location/distance_calculator.dart';
import 'package:e_waste/domain/entities/all_objects.dart';
import 'package:e_waste/domain/entities/location.dart';
import 'package:e_waste/domain/entities/object_from_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../blur_controller.dart';
import 'all_objects_from_api_to_marker_wrapper.dart';
import 'home_presenter.dart';

class HomeController extends Controller
    implements ObjectTappedObserver, BlurController {
  @override
  bool shouldBlurWidget = false;

  AllObjects _allObjects;
  BuildContext context;
  Location currentLocation;
  double _range = 5000;
  Location oldCurrentLocation;

  List<Marker> get allObjects =>
      AllObjectsFromApiToMarkerWrapper(_allObjects, this)
          .getAllObjectsAsMarkers(context); // data used by the View
  final HomePresenter homePresenter;

  StreamController<Location> currentLocationStreamController =
      StreamController.broadcast();
  Stream<Location> currentLocationPeriodicStream =
      Stream<Location>.periodic(Duration(seconds: 1));

  // Presenter should always be initialized this way
  HomeController(usersRepo)
      : homePresenter = HomePresenter(usersRepo),
        super();

  @override
  // this is called automatically by the parent class
  void initListeners() {
    currentLocationPeriodicStream.listen((_) {
      if (oldCurrentLocation != currentLocation) {
        oldCurrentLocation = currentLocation;
        getAllObjects();
        print("search location");
      }
    });

    homePresenter.getAllObjectsOnNext = (AllObjects allobjects) {
      _allObjects = allobjects;
      refreshUI(); // Refreshes the UI manually
    };
    homePresenter.getAllObjectsOnComplete = () {
      print('All objects retrieved');
    };

    // On error, show a snackbar, remove the user, and refresh the UI
    homePresenter.getAllObjectsOnError = (e) {
      print('Could not retrieve all objects.');
      ScaffoldState state = Scaffold.of(context);
      state.showSnackBar(SnackBar(
              content:
                  Text(AppLocalizations.of(context).translate(e.toString()))) ??
          "error");
      _allObjects = null;
      refreshUI(); // Refreshes the UI manually
    };
  }

  getAllObjects() => homePresenter.getAllObjects(currentLocation, _range);

  void didSetLocation(Location northeast, Location southwest) {
    currentLocation = _getCenter(northeast, southwest);
    _range = DistanceCalculator.calculateDistance(northeast, southwest) / 2;
  }

  Location _getCenter(Location northeast, Location southwest) {
    double latitudeCenter = (northeast.latitude + southwest.latitude) / 2;
    double longitudeCenter = (northeast.longitude + southwest.longitude) / 2;
    return Location(latitudeCenter, longitudeCenter);
  }

  @override
  void onResumed() {
    super.onResumed();
  }

  @override
  void dispose() {
    homePresenter.dispose(); // don't forget to dispose of the presenter
    super.dispose();
  }

  @override
  void didTapObject(ObjectFromApi objectFromApi) {}
}
