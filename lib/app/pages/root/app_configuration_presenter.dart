import 'package:e_waste/domain/usecases/get_app_configuration_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AppConfigurationPresenter extends Presenter {
  Function getAppConfigurationOnNext;
  Function getAppConfigurationOnComplete;
  Function getAppConfigurationOnError;

  final GetAppConfigurationUseCase getAppConfigurationUseCase;
  AppConfigurationPresenter(appConfigurationRepo)
      : getAppConfigurationUseCase =
            GetAppConfigurationUseCase(appConfigurationRepo);

  void getAppConfiguration() {
    getAppConfigurationUseCase.execute(
        _GetAppConfigurationUseCaseObserver(this),
        GetAppConfigurationUseCaseParams(1));
  }

  @override
  void dispose() {
    getAppConfigurationUseCase.dispose();
  }
}

class _GetAppConfigurationUseCaseObserver
    extends Observer<GetAppConfigurationUseCaseResponse> {
  final AppConfigurationPresenter presenter;
  _GetAppConfigurationUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    assert(presenter.getAppConfigurationOnComplete != null);
    presenter.getAppConfigurationOnComplete();
  }

  @override
  void onError(e) {
    assert(presenter.getAppConfigurationOnError != null);
    presenter.getAppConfigurationOnError(e);
  }

  @override
  void onNext(response) {
    assert(presenter.getAppConfigurationOnNext != null);
    presenter.getAppConfigurationOnNext(response.appConfiguration);
  }
}
