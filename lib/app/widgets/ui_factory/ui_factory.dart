import 'package:e_waste/app/widgets/ui_factory/views/app_bottom_tab_bar.dart';
import 'package:e_waste/app/widgets/ui_factory/views/custom_label.dart';
import 'package:e_waste/app/widgets/ui_factory/views/material_activity_indicator.dart';
import 'package:flutter/material.dart';

import 'interfaces/activity_indicator.dart';
import 'interfaces/bottom_tab_bar.dart';
import 'interfaces/label.dart';

class UIFactory {
  static IActivityIndicator createLoader(LoaderType type) {
    switch (type) {
      case LoaderType.simpleLoader:
        return _createSimpleLoader();
    }
    return null;
  }

  static BottomTabBar createBottomTabBar(
      int selectedIndex, List<Item> items, OnItemChangeCallback callback) {
    return AppBottomTabBar(selectedIndex, items, callback);
  }

  static Label createLabel(String text, Color color, String font, double fontSize) {
    return CustomLabel(text, color, font, fontSize);
  }

  static IActivityIndicator _createSimpleLoader() {
    return MaterialActivityIndicator();
  }
}

enum LoaderType { simpleLoader }
