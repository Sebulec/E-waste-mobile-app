import 'package:e_waste/domain/entities/form_type.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class FormPresenter extends Presenter {
  final FormType formType;

  FormPresenter(this.formType);

  @override
  void dispose() {}
}
