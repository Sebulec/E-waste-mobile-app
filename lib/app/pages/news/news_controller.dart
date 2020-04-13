import 'dart:async';

import 'package:e_waste/app/pages/news/new_model_view.dart';
import 'package:e_waste/domain/entities/news.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'news_presenter.dart';

class NewsController extends Controller {
  List<NewsModelView> news;
  List<News> _news;

  int _currentPage = 0;
  bool _isFinishedLoadingAllNews = false;

  List<NewsModelView> get allNews =>
      _news.map((n) => NewsModelView.fromNews(n)).toList();
  final NewsPresenter newsPresenter;
  StreamController<bool> loadNewsStreamController = StreamController.broadcast();

  NewsController(newsRepo)
      : newsPresenter = NewsPresenter(newsRepo),
        super();

  @override
  void initListeners() {
    // newsPresenter.
  }

  _getNews() {
    _currentPage += 1;

  }

  @override
  void onResumed() {
    super.onResumed();
  }

  @override
  void dispose() {
    newsPresenter.dispose(); // don't forget to dispose of the presenter
    super.dispose();
  }
}
