import 'package:json_annotation/json_annotation.dart';

part 'object_from_api.g.dart';

@JsonSerializable()
class ObjectFromApi {
  final String name;
  final String iconUrl;
  final String googlePlaceId;
  final double lat;
  final double long;

  ObjectFromApi(this.name, this.iconUrl, this.googlePlaceId, this.lat, this.long);

  factory ObjectFromApi.fromJson(Map<String, dynamic> json) => _$ObjectFromApiFromJson(json);
  Map<String, dynamic> toJson() => _$ObjectFromApiToJson(this);
}
