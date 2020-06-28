import 'package:e_waste/domain/entities/dto/news_dto.dart';
import 'package:e_waste/domain/entities/news.dart';

import 'core/api_base.dart';
import 'package:e_waste/domain/repositories/news_repository.dart';

class JsonNewsRepository extends NewsRepository {
  final ApiBase _apiBase;
  final String _getNews = "articles";
  final int pageLimit = 10;

  JsonNewsRepository(this._apiBase);

  @override
  Future<List<News>> getNews(int startPage) async {
    final Iterable response = await _apiBase
        .get("${_getNews}?_start=${startPage}&_limit=${pageLimit}");
    return response
        .map((e) => NewsDto.fromJson(e).asNews(_apiBase.baseUrl))
        .toList();
  }
}
