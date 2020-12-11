import 'package:e_waste/app/widgets/alert.dart';
import 'package:e_waste/app/widgets/analytics_screen.dart';
import 'package:e_waste/app/widgets/constants.dart';
import 'package:e_waste/app/widgets/ui_factory/ui_factory.dart';
import 'package:e_waste/app_localizations.dart';
import 'package:e_waste/data/services/analytics_service_impl.dart';
import 'package:e_waste/domain/entities/form_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'form_controller.dart';

class FormPage extends View {
  final FormType _formType;

  FormPage(this._formType);

  @override
  _FormPageState createState() => _FormPageState(_formType);
}

class _FormPageState extends ViewState<FormPage, FormController>
    with AnalyticsScreen {
  final FormType _formType;

  @override
  String get screenName {
    switch (_formType) {
      case FormType.illegalDump:
        return ScreenName.REPORT_ILLEGAL_DUMP_NAME;
    }
    return "MISSIG NAME";
  }

  _FormPageState(this._formType) : super(FormController(_formType)) {
    setCurrentScreen();
  }

  @override
  Widget buildPage() {
    return _buildForm();
  }

  _buildForm() => Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).translate("report_illegal_trash"),
            style: TextStyle(fontFamily: EWasteLayout.HEADER_FONT),
          ),
        ),
        body: Container(
          child: _generateForm(),
        ),
      );

  _buildLoader() =>
      Center(child: UIFactory.createLoader(LoaderType.simpleLoader).render());

  _generateForm() => Form(child: null);
}
