import 'package:e_waste/app/widgets/ui_factory/interfaces/field.dart';
import 'package:flutter/material.dart';

abstract class IFormWidget {
  List<Field> fields = List();

  addField(Field field) {
    fields.add(field);
  }

  Widget build() => Container(
        child: CustomScrollView(
          slivers: [],
        ),
      );

  // List<Widget> _fieldsToViews() =>
  //     fields.map((field) => _FieldToWidgetGenerator.build(field));
}

// class _FieldToWidgetGenerator {

//   static TextFormField build(Field field) {
//     switch (field.type) {
//       case FieldType.textField:
//         return 
//       case FieldType.image:
//         // TODO: Handle this case.
//         break;
//     }
//   }
}
