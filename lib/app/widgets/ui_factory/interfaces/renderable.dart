import 'package:flutter/widgets.dart';

abstract class Renderable extends Widget {
  Widget render();
  Element createElement() {
    return render().createElement();
  }
}
