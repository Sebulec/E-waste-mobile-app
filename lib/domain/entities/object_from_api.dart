import 'package:json_annotation/json_annotation.dart';

import 'object_type.dart';
import 'waste_type.dart';

part 'object_from_api.g.dart';

@JsonSerializable()
class ObjectFromApi {
  final String name;
  final String iconUrl;
  final String googlePlaceId;
  final double lat;
  final double long;
  final Map data;
  String get address => data["vicinity"];
  ObjectType objectType;
  @JsonKey(name: "waste_types")
  List<WasteType> wasteTypes;

  ObjectFromApi(this.name, this.iconUrl, this.googlePlaceId, this.lat,
      this.long, this.data);

  factory ObjectFromApi.fromJson(Map<String, dynamic> json) =>
      _$ObjectFromApiFromJson(json);
  Map<String, dynamic> toJson() => _$ObjectFromApiToJson(this);
}
