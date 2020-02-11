import 'package:e_waste/domain/entities/all_objects.dart';
import 'package:e_waste/domain/entities/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'home_presenter.dart';

class HomeController extends Controller {
  int _counter;
  AllObjects _allObjects;
  int get counter => _counter;
  AllObjects get user => _allObjects; // data used by the View
  final HomePresenter homePresenter;
  // Presenter should always be initialized this way
  HomeController(usersRepo)
      : _counter = 0,
        homePresenter = HomePresenter(usersRepo),
        super();

  @override
  // this is called automatically by the parent class
  void initListeners() {
    homePresenter.getAllObjectsOnNext = (AllObjects allobjects) {
      print(user.toString());
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

  getAllObjects() => homePresenter.getAllObjects(Location(1, 1));

  void buttonPressed() {
    _counter++;
    refreshUI();
  }

  @override
  void onResumed() {
    print("On resumed");
    super.onResumed();
  }

  @override
  void dispose() {
    homePresenter.dispose(); // don't forget to dispose of the presenter
    super.dispose();
  }
}
