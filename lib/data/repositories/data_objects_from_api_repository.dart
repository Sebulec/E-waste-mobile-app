import 'package:e_waste/domain/entities/all_objects.dart';
import 'package:e_waste/domain/entities/location.dart';
import 'package:e_waste/domain/entities/object_from_api.dart';
import 'package:e_waste/domain/entities/object_type.dart';
import 'package:e_waste/domain/repositories/objects_from_api_repository.dart';

class DataObjectsFromApiRepository extends ObjectsFromApiRepository {
  List<ObjectFromApi> customObjects;
  List<ObjectFromApi> shopObjects;

  // sigleton
  static DataObjectsFromApiRepository _instance =
      DataObjectsFromApiRepository._internal();

  DataObjectsFromApiRepository._internal() {
    customObjects = List<ObjectFromApi>();
    customObjects.addAll([
      ObjectFromApi(
          "Biedronka",
          "https://static.pepper.pl/live_pl/threads/thread_large/default/233710_1.jpg",
          "",
          51.142071,
          16.888347)
        ..objectType = ObjectType.custom
    ]);
    shopObjects = List<ObjectFromApi>();
    shopObjects.addAll([
      ObjectFromApi(
          "Ośrodek",
          "https://flutter.dev/assets/flutter-lockup-c13da9c9303e26b8d5fc208d2a1fa20c1ef47eb021ecadf27046dea04c0cebf6.png",
          "",
          51.1459711,
          16.8583618)
        ..objectType = ObjectType.shop
    ]);
  }

  factory DataObjectsFromApiRepository() => _instance;

  @override
  Future<AllObjects> getAllObjectsForLocation(Location location) async {
    return AllObjects(customObjects, shopObjects);
  }
}
