import 'dart:async';

import 'package:e_waste/app/pages/news/new_model_view.dart';
import 'package:e_waste/domain/entities/news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'news_presenter.dart';

class NewsController extends Controller {
  List<NewsModelView> news = [];
  List<News> _news = [];

  BuildContext context;

  final NewsPresenter newsPresenter;

  Stream<bool> get loadNewsCompleted => _loadNewsStreamController.stream;
  Stream<Error> get errorNewsCompleted => _errorNewsStreamController.stream;

  StreamController<bool> _loadNewsStreamController =
      StreamController.broadcast();
  StreamController<Error> _errorNewsStreamController =
      StreamController.broadcast();

  NewsController(newsRepo)
      : newsPresenter = NewsPresenter(newsRepo),
        super();

  @override
  void initListeners() {
    newsPresenter.getNews(0);

    newsPresenter.getNewsOnNext = (List<News> news) {
      _news = news;
      _saveNewsToViewModel();
      refreshUI(); // Refreshes the UI manually
    };

    newsPresenter.getNewsOnComplete = () {
      print('News retrieved');
      _loadNewsStreamController.add(true);
    };

    // On error, show a snackbar, remove the user, and refresh the UI
    newsPresenter.getNewsOnError = (e) {
      print('Could not retrieve all news.');
      _errorNewsStreamController.add(e);
      _news = null;
      refreshUI(); // Refreshes the UI manually
    };
  }

  _saveNewsToViewModel() {
    news = _news.map((n) => NewsModelView.fromNews(n)).toList();
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
