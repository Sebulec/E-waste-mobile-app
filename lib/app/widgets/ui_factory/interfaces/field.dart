import 'package:flutter/material.dart';

class Field {
  final String name;
  final FieldType type;
  final bool obligatory;
  final TextEditingController textEditingController;

  Field(this.name, this.type, this.obligatory, this.textEditingController);
}

enum FieldType { textField, image }
