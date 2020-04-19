import 'dart:async';

import 'package:e_waste/domain/entities/news.dart';
import 'package:e_waste/domain/repositories/news_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetNewsUseCase
    extends UseCase<GetNewsUseCaseResponse, GetNewsUseCaseParams> {
  final NewsRepository _newsRepository;

  GetNewsUseCase(this._newsRepository) {
    assert(this._newsRepository != null);
  }

  @override
  Future<Stream<GetNewsUseCaseResponse>> buildUseCaseStream(
      GetNewsUseCaseParams params) async {
    final StreamController<GetNewsUseCaseResponse> controller =
        StreamController();
    try {
      // get news
      List<News> news = await _newsRepository.getNews(params.start);
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(GetNewsUseCaseResponse(news));
      logger.finest('GetNewsUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetNewsUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetNewsUseCaseResponse {
  final List<News> news;

  GetNewsUseCaseResponse(this.news);
}

class GetNewsUseCaseParams {
  final int start;

  GetNewsUseCaseParams(this.start);
}
