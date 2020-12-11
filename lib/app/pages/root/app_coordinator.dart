import 'package:flutter/material.dart';

import 'package:e_waste/app/pages/form/form_view.dart';
import 'package:e_waste/domain/entities/form_type.dart';

class AppCoordinator {
  final BuildContext _context;

  AppCoordinator(BuildContext context): _context = context;

  void navigateToReportForm(FormType formType) {
    Navigator.push(
      _context,
      MaterialPageRoute(
          builder: (context) => FormPage(formType), fullscreenDialog: true),
    );
  }
}
