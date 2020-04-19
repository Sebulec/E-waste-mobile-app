import 'package:flutter/material.dart';

void showSnackBar(ScaffoldState state, String message) {
  state.showSnackBar(SnackBar(content: Text(message)));
}
