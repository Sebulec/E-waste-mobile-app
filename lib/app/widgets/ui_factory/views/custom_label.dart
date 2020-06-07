import 'package:e_waste/app/widgets/constants.dart';
import 'package:e_waste/app/widgets/ui_factory/interfaces/label.dart';
import 'package:flutter/widgets.dart';

class CustomLabel extends Label {
  final String _text;
  final Color _color;
  final Font _font;

  CustomLabel(this._text, this._color, this._font) : super(_text) {
    
  }
}
