import 'package:e_waste/domain/entities/news.dart';

class NewsModelView {
  final String headerTitle;
  final String dateTime;
  final String imageUrl;
  final String htmlText;

  NewsModelView(this.headerTitle, this.dateTime, this.htmlText, this.imageUrl);

  factory NewsModelView.fromNews(News news) {
    return NewsModelView(
        news.title, news.date.toString(), news.text, news.imageUrl);
  }
}
