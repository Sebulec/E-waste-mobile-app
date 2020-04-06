import 'package:e_waste/app/widgets/analytics_screen.dart';
import 'package:e_waste/app/widgets/constants.dart';
import 'package:e_waste/data/services/analytics_service_impl.dart';
import 'package:e_waste/domain/repositories/news_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'news_controller.dart';

class NewsPage extends View {
  final NewsRepository newsRepository;

  NewsPage(this.newsRepository);

  @override
  _NewsPageState createState() => _NewsPageState(this.newsRepository);
}

class _NewsPageState extends ViewState<NewsPage, NewsController>
    with AnalyticsScreen {
  bool _shouldShowNews = false;

  @override
  String get screenName => ScreenName.NEWS_NAME;

  _NewsPageState(NewsRepository newsRepository)
      : super(NewsController(newsRepository)) {
    setCurrentScreen();
  }

  @override
  Widget buildPage() {
    return _shouldShowNews ? _buildListView() : _buildLoader();
  }

  _buildListView() => ListView.builder(
        itemCount: controller.news.length + 1,
        padding: EdgeInsets.symmetric(vertical: EWasteLayout.LIST_VIEW_PADDING),
        itemBuilder: _itemBuild,
      );

  _itemBuild(BuildContext context, int index) {
    if (index == controller.news.length) {
      return _buildLoader();
    } else {
      return ListTile(
        leading: CircleAvatar(radius: 30.0, backgroundColor: Colors.amber),
        title: Text(controller.news[index].headerTitle),
        subtitle: Text("Test"),
      );
    }
  }

  _buildLoader() => Container(
      child: Center(child: CircularProgressIndicator()), color: Colors.white);
}
