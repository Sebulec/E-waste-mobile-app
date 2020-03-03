import 'package:e_waste/domain/entities/location.dart';
import 'package:e_waste/domain/usecases/get_all_objects_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomePresenter extends Presenter {
  Function getAllObjectsOnNext;
  Function getAllObjectsOnComplete;
  Function getAllObjectsOnError;

  final GetAllObjectsUseCase getAllObjectsUseCase;
  HomePresenter(objectsFromApiRepo)
      : getAllObjectsUseCase = GetAllObjectsUseCase(objectsFromApiRepo);

  void getAllObjects(Location location, double range) {
    getAllObjectsUseCase.execute(_GetAllObjectsUseCaseObserver(this),
        GetAllObjectsUseCaseParams(location, range));
  }

  @override
  void dispose() {
    getAllObjectsUseCase.dispose();
  }
}

class _GetAllObjectsUseCaseObserver
    extends Observer<GetAllObjectsUseCaseResponse> {
  final HomePresenter presenter;
  _GetAllObjectsUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    assert(presenter.getAllObjectsOnComplete != null);
    presenter.getAllObjectsOnComplete();
  }

  @override
  void onError(e) {
    assert(presenter.getAllObjectsOnError != null);
    presenter.getAllObjectsOnError(e);
  }

  @override
  void onNext(response) {
    assert(presenter.getAllObjectsOnNext != null);
    presenter.getAllObjectsOnNext(response.allObjects);
  }
}
