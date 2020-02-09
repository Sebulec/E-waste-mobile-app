import 'object_from_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_objects.g.dart';

@JsonSerializable()
class AllObjects {
  final List<ObjectFromApi> custom;
  final List<ObjectFromApi> shops;

  AllObjects(this.custom, this.shops);

  factory AllObjects.fromJson(Map<String, dynamic> json) => _$AllObjectsFromJson(json);
  Map<String, dynamic> toJson() => _$AllObjectsToJson(this);
}