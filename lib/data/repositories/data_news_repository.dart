import 'package:e_waste/domain/entities/news.dart';
import 'package:e_waste/domain/repositories/news_repository.dart';

class DataNewsRepository extends NewsRepository {
  List<News> firstList;
  List<News> secondList;

  DataNewsRepository() {
    for (int i = 0; i < 10; i++) {
      News news = News(
          "${i}",
          "title ${i}",
          "Author",
          """<h1> Heyo Poo</h1> <br> <h3> Heyo ${i} lala</h3> <a href="http://google.com">test</a>""",
          DateTime.now());
      firstList.add(news);
    }

    for (int i = 10; i < 20; i++) {
      News news = News(
          "${i}",
          "title ${i}",
          "Author",
          """<h1> Heyo Poo</h1> <br> <h3> Heyo ${i} lala</h3> <a href="http://google.com">test</a>""",
          DateTime.now());
      secondList.add(news);
    }
  }

  @override
  Future<List<News>> getNews(int startPage) async {
    if (startPage == 0) {
      return firstList;
    } else if (startPage == 1) {
      return secondList;
    } else {
      return [];
    }
  }
}
