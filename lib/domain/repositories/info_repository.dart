import 'package:e_waste/domain/entities/info.dart';

abstract class InfoRepository {
  Future<Info> getInfo(String countryCode);
}
