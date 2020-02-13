import 'package:e_waste/domain/usecases/get_info_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AboutPresenter extends Presenter {
  Function getInfoOnNext;
  Function getInfoOnComplete;
  Function getInfoOnError;

  final GetInfoUseCase getInfoUseCase;
  AboutPresenter(infoRepo) : getInfoUseCase = GetInfoUseCase(infoRepo);

  void getInfo(String countryCode) {
    getInfoUseCase.execute(
        _GetInfoUseCaseObserver(this), GetInfoUseCaseParams(countryCode));
  }

  @override
  void dispose() {
    getInfoUseCase.dispose();
  }
}

class _GetInfoUseCaseObserver extends Observer<GetInfoUseCaseResponse> {
  final AboutPresenter presenter;
  _GetInfoUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    assert(presenter.getInfoOnComplete != null);
    presenter.getInfoOnComplete();
  }

  @override
  void onError(e) {
    assert(presenter.getInfoOnError != null);
    presenter.getInfoOnError(e);
  }

  @override
  void onNext(response) {
    assert(presenter.getInfoOnNext != null);
    presenter.getInfoOnNext(response.info);
  }
}
