import 'package:e_waste/domain/entities/news.dart';

abstract class NewsRepository {
  final newsPagesLimit = 10;
  Future<List<News>> getNews(int startPage);
}