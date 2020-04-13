import 'package:e_waste/app/widgets/ui_factory/interfaces/activity_indicator.dart';
import 'package:flutter/material.dart';

class MaterialActivityIndicator extends IActivityIndicator {
  @override
  Widget render() {
    return CircularProgressIndicator(
      backgroundColor: Color(0xFFECECEC),
      valueColor: AlwaysStoppedAnimation<Color>(
        Colors.black.withOpacity(0.65),
      ),
    );
  }

  @override
  Element createElement() {
    return render().createElement();
  }
}
