import 'package:e_waste/app/widgets/ui_factory/interfaces/label.dart';
import 'package:flutter/widgets.dart';

class CustomLabel extends Label {
  final String _text;
  final Color _color;
  final String _font;
  final double _fontSize;

  CustomLabel(this._text, this._color, this._font, this._fontSize)
      : super(_text, _color, _font, _fontSize);
}
