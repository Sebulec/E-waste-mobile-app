import 'package:e_waste/domain/usecases/get_news_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class NewsPresenter extends Presenter {
  Function getNewsOnNext;
  Function getNewsOnComplete;
  Function getNewsOnError;

  final GetNewsUseCase getNewsUseCase;
  NewsPresenter(newsRepository)
      : getNewsUseCase = GetNewsUseCase(newsRepository);

  void getNews(int start) {
    getNewsUseCase.execute(
        _GetNewsUseCaseObserver(this), GetNewsUseCaseParams(start));
  }

  @override
  void dispose() {
    getNewsUseCase.dispose();
  }
}

class _GetNewsUseCaseObserver extends Observer<GetNewsUseCaseResponse> {
  final NewsPresenter presenter;

  _GetNewsUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    assert(presenter.getNewsOnComplete != null);
    presenter.getNewsOnComplete();
  }

  @override
  void onError(e) {
    assert(presenter.getNewsOnError != null);
    presenter.getNewsOnError(e);
  }

  @override
  void onNext(response) {
    assert(presenter.getNewsOnNext != null);
    presenter.getNewsOnNext(response.news);
  }
}
