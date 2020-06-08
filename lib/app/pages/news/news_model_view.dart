import 'package:e_waste/domain/entities/news.dart';

class NewsModelView {
  final String authorName;
  final String headerTitle;
  final String dateTime;
  final String htmlText;

  NewsModelView(
      this.authorName, this.headerTitle, this.dateTime, this.htmlText);

  factory NewsModelView.fromNews(News news) {
    return NewsModelView(
        news.author, news.title, news.date.toString(), news.text);
  }
}
