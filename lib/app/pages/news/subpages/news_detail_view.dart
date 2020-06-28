import 'dart:ui';

import 'package:e_waste/app/pages/news/news_model_view.dart';
import 'package:e_waste/app/widgets/analytics_screen.dart';
import 'package:e_waste/app/widgets/constants.dart';
import 'package:e_waste/app/widgets/ui_factory/ui_factory.dart';
import 'package:e_waste/data/services/analytics_service_impl.dart';
import 'package:e_waste/domain/repositories/url_opener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'news_detail_controller.dart';

class NewsDetailPage extends View {
  final NewsModelView _newsModelView;
  final UrlOpener _urlOpener;

  NewsDetailPage(this._newsModelView, this._urlOpener);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState(_newsModelView);
}

class _NewsDetailPageState
    extends ViewState<NewsDetailPage, NewsDetailController>
    with AnalyticsScreen, SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    _scaleAnimation = CurvedAnimation(
        parent: _animationController, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    _animationController.forward();
  }

  @override
  String get screenName => ScreenName.NEWS_DETAIL_NAME;

  _NewsDetailPageState(NewsModelView newsModelView)
      : super(NewsDetailController(newsModelView)) {
    setCurrentScreen();
  }

  @override
  Widget buildPage() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: SingleChildScrollView(
                        child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: _obtainWidgetsForNewsViewModel(),
                            ))),
                    decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0))),
                  ),
                ),
              ),
            )));
  }

  List<Widget> _obtainWidgetsForNewsViewModel() => [
        UIFactory.createLabel(controller.currentNewsModelView.headerTitle,
            Colors.amberAccent, EWasteLayout.HEADER_FONT, 28,
            textAlign: TextAlign.center),
        UIFactory.createImageView(controller.currentNewsModelView.imageUrl),
        Container(
          child: UIFactory.createMarkdownText(
              controller.currentNewsModelView?.htmlText ?? ""),
        )
      ];
}
