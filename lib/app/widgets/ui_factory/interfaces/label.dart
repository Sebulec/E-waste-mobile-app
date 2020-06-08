import 'package:flutter/material.dart';

abstract class Label extends Text {
  Label(String data, Color color, String font, double fontSize)
      : super(data, style: TextStyle(fontFamily: font, fontSize: fontSize));
}
