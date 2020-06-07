import 'package:e_waste/app/pages/news/new_model_view.dart';
import 'package:e_waste/app/widgets/alert.dart';
import 'package:e_waste/app/widgets/analytics_screen.dart';
import 'package:e_waste/app/widgets/constants.dart';
import 'package:e_waste/app/widgets/ui_factory/ui_factory.dart';
import 'package:e_waste/app_localizations.dart';
import 'package:e_waste/data/services/analytics_service_impl.dart';
import 'package:e_waste/domain/repositories/news_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'news_controller.dart';
import 'subpages/news_detail_view.dart';

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
    controller.loadNewsCompleted.listen((_) {
      _shouldShowNews = true;
    });
    controller.errorNewsCompleted.listen((error) {
      ScaffoldState state = Scaffold.of(context);
      showSnackBar(
          state, AppLocalizations.of(context).translate(error.toString()));
    });
  }

  @override
  Widget buildPage() {
    return _shouldShowNews ? _buildListView() : _buildLoader();
  }

  _buildListView() => ListView.builder(
        itemCount: controller.news.length,
        padding: EdgeInsets.symmetric(vertical: EWasteLayout.LIST_VIEW_PADDING),
        itemBuilder: _itemBuild,
      );

  Widget _itemBuild(BuildContext context, int index) {
    if (index == controller.news.length) {
      return _buildLoader();
    } else {
      return ListTile(
        leading: CircleAvatar(radius: 30.0, backgroundColor: Colors.amber),
        title: Text(controller.news[index].headerTitle),
        subtitle: Text("Test"),
        onTap: () {
          _navigateToNewsDetailPage(context, controller.news[index]);
        },
      );
    }
  }

  _buildLoader() =>
      Center(child: UIFactory.createLoader(LoaderType.simpleLoader).render());

  _navigateToNewsDetailPage(BuildContext context, NewsModelView newsModelView) {
    showDialog(
      context: context,
      builder: (_) => NewsDetailPage(null),
    );
  }
}
