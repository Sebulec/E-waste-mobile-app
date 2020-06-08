import 'package:e_waste/app/pages/news/news_model_view.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class NewsDetailController extends Controller {
  final NewsModelView _newsModelView;

  NewsModelView get currentNewsModelView => _newsModelView;

  NewsDetailController(this._newsModelView);

  @override
  void initListeners() {
    // TODO: implement initListeners
  }
}
