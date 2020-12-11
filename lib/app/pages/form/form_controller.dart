import 'package:e_waste/domain/entities/form_type.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'form_presenter.dart';

class FormController extends Controller {
  final FormPresenter formPresenter;
  final FormType formType;

  FormController(this.formType) : formPresenter = FormPresenter(formType);
  @override
  void initListeners() {
    // TODO: implement initListeners
  }
}
