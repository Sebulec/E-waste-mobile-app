// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object_from_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjectFromApi _$ObjectFromApiFromJson(Map<String, dynamic> json) {
  return ObjectFromApi(
    json['name'] as String,
    json['iconUrl'] as String,
    json['googlePlaceId'] as String,
    (json['lat'] as num)?.toDouble(),
    (json['long'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ObjectFromApiToJson(ObjectFromApi instance) =>
    <String, dynamic>{
      'name': instance.name,
      'iconUrl': instance.iconUrl,
      'googlePlaceId': instance.googlePlaceId,
      'lat': instance.lat,
      'long': instance.long,
    };
