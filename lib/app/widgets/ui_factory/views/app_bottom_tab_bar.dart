import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:e_waste/app/widgets/constants.dart';
import 'package:flutter/material.dart';

import 'package:e_waste/app/widgets/ui_factory/interfaces/bottom_tab_bar.dart';

class AppBottomTabBar extends BottomTabBar {
  final List<BottomNavyBarItem> _items;

  AppBottomTabBar(
      int selectedIndex, List<Item> items, OnItemChangeCallback callback)
      : _items = items.map((item) => _BottomNavyBarItemWrapper(item)).toList(),
        super(selectedIndex, items, callback);

  @override
  Widget render() {
    return BottomNavyBar(
      selectedIndex: selectedIndex,
      showElevation: false, // use this to remove appBar's elevation
      onItemSelected: onItemSelected,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      items: _items,
    );
  }

  @override
  Element createElement() {
    return render().createElement();
  }
}

class _BottomNavyBarItemWrapper extends BottomNavyBarItem {
  _BottomNavyBarItemWrapper(
    Item item,
  ) : super(
            title: Text(item.name),
            icon: item.icon,
            activeColor: item.activeColor);
}
