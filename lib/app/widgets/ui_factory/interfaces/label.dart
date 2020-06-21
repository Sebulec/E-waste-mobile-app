import 'package:flutter/material.dart';

abstract class Label extends Text {
  Label(String data, Color color, String font, double fontSize,
      TextAlign textAlign)
      : super(data,
            textAlign: textAlign,
            style: TextStyle(fontFamily: font, fontSize: fontSize));
}
