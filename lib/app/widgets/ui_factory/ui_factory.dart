import 'package:e_waste/app/widgets/constants.dart';
import 'package:e_waste/app/widgets/ui_factory/views/app_bottom_tab_bar.dart';
import 'package:e_waste/app/widgets/ui_factory/views/custom_label.dart';
import 'package:e_waste/app/widgets/ui_factory/views/material_activity_indicator.dart';
import 'package:e_waste/domain/repositories/url_opener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/rich_text_parser.dart';

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

  static Label createLabel(
      String text, Color color, String font, double fontSize,
      {TextAlign textAlign = TextAlign.start}) {
    return CustomLabel(text, color, font, fontSize, textAlign);
  }

  static IActivityIndicator _createSimpleLoader() {
    return MaterialActivityIndicator();
  }

  static Html createHtmlText(String htmlText,
          {double padding = EWasteLayout.PADDING, UrlOpener urlOpener}) =>
      Html(
          data: htmlText,
          padding: EdgeInsets.all(padding),
          onLinkTap: (url) {
            urlOpener.openUrl(url);
          });
}

enum LoaderType { simpleLoader }
