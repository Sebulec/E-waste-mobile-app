import 'package:e_waste/app/pages/news/news_model_view.dart';
import 'package:e_waste/app/widgets/alert.dart';
import 'package:e_waste/app/widgets/analytics_screen.dart';
import 'package:e_waste/app/widgets/constants.dart';
import 'package:e_waste/app/widgets/ui_factory/ui_factory.dart';
import 'package:e_waste/app_localizations.dart';
import 'package:e_waste/data/services/analytics_service_impl.dart';
import 'package:e_waste/domain/repositories/news_repository.dart';
import 'package:e_waste/domain/repositories/url_opener.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'news_controller.dart';
import 'subpages/news_detail_view.dart';

class NewsPage extends View {
  final NewsRepository newsRepository;
  final UrlOpener urlOpener;

  NewsPage(this.newsRepository, this.urlOpener);

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
      return _buildListTile(controller.news[index]);
    }
  }

  _buildListTile(NewsModelView news) => ListTile(
        leading: Container(
          child: UIFactory.createImageView(news.imageUrl),
          width: 50,
          height: 50,
        ),
        title: UIFactory.createLabel(
            news.headerTitle, EWasteLayout.ACCENT_COLOR, Font.GOTHAM, 16),
        onTap: () {
          _navigateToNewsDetailPage(context, news);
        },
      );

  _buildLoader() =>
      Center(child: UIFactory.createLoader(LoaderType.simpleLoader).render());

  _navigateToNewsDetailPage(BuildContext context, NewsModelView newsModelView) {
    showDialog(
      context: context,
      builder: (_) => NewsDetailPage(newsModelView, widget.urlOpener),
    );
  }
}
