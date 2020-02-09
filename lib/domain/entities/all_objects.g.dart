// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_objects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllObjects _$AllObjectsFromJson(Map<String, dynamic> json) {
  return AllObjects(
    (json['custom'] as List)
        ?.map((e) => e == null
            ? null
            : ObjectFromApi.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['shops'] as List)
        ?.map((e) => e == null
            ? null
            : ObjectFromApi.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AllObjectsToJson(AllObjects instance) =>
    <String, dynamic>{
      'custom': instance.custom,
      'shops': instance.shops,
    };
