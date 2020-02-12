import 'package:e_waste/domain/entities/all_objects.dart';
import 'package:e_waste/domain/entities/location.dart';
import 'package:e_waste/domain/entities/object_from_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'all_objects_from_api_to_marker_wrapper.dart';
import 'home_presenter.dart';

class HomeController extends Controller implements ObjectTappedObserver {
  AllObjects _allObjects;

  List<Marker> get allObjects =>
      AllObjectsFromApiToMarkerWrapper(_allObjects, this)
          .getAllObjectsAsMarkers(); // data used by the View
  final HomePresenter homePresenter;
  Location currentLocation;

  // Presenter should always be initialized this way
  HomeController(usersRepo)
      : homePresenter = HomePresenter(usersRepo),
        super();

  @override
  // this is called automatically by the parent class
  void initListeners() {
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
      ScaffoldState state = getState();
      state.showSnackBar(SnackBar(content: Text(e.message)));
      _allObjects = null;
      refreshUI(); // Refreshes the UI manually
    };
  }

  getAllObjects() => homePresenter.getAllObjects(currentLocation);

  void didSetLocation(Location location) {
    currentLocation = location;
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
