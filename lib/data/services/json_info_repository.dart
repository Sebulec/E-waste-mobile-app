import 'package:e_waste/domain/entities/info.dart';
import 'package:e_waste/domain/repositories/info_repository.dart';

import 'core/api_base.dart';

class JsonInfoRepository extends InfoRepository {
  final ApiBase _apiBase;
  final String _getInfo = "infos";

  JsonInfoRepository(this._apiBase);

  @override
  Future<Info> getInfo(String countryCode) async {
    final Iterable response =
        await _apiBase.get("${_getInfo}?language=${countryCode}");
    return Info.fromJson(response.first);
  }
}
