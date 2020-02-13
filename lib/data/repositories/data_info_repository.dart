import 'package:e_waste/domain/entities/info.dart';
import 'package:e_waste/domain/repositories/info_repository.dart';

class DataInfoRepository extends InfoRepository {
  Info info = Info(
      """<h1> Heyo Poo</h1> <br> <h3> Heyo lala</h3> <a href="http://google.com">test</a>""");
  // sigleton
  static DataInfoRepository _instance = DataInfoRepository._internal();

  DataInfoRepository._internal();

  @override
  Future<Info> getInfo(String countryCode) async {
    return info;
  }

  factory DataInfoRepository() => _instance;
}
