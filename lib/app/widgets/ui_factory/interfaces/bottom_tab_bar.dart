import 'package:e_waste/app/widgets/constants.dart';
import 'package:e_waste/app/widgets/ui_factory/interfaces/renderable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef OnItemChangeCallback(int selectedIndex);

abstract class BottomTabBar extends Widget implements Renderable {
  final List<Item> items;
  final OnItemChangeCallback callback;
  final int selectedIndex;

  BottomTabBar(this.selectedIndex, this.items, this.callback);

  onItemSelected(int item) {
    callback(item);
  }
}

class Item {
  String name;
  Icon icon;
  Color activeColor;

  Item(this.name, this.icon, {this.activeColor = EWasteLayout.PRIMARY_COLOR});
}
