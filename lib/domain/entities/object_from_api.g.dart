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
    json['data'] as Map<String, dynamic>,
  )
    ..objectType = _$enumDecodeNullable(_$ObjectTypeEnumMap, json['objectType'])
    ..wasteTypes = (json['waste_types'] as List)
        ?.map((e) =>
            e == null ? null : WasteType.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ObjectFromApiToJson(ObjectFromApi instance) =>
    <String, dynamic>{
      'name': instance.name,
      'iconUrl': instance.iconUrl,
      'googlePlaceId': instance.googlePlaceId,
      'lat': instance.lat,
      'long': instance.long,
      'data': instance.data,
      'objectType': _$ObjectTypeEnumMap[instance.objectType],
      'waste_types': instance.wasteTypes,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ObjectTypeEnumMap = {
  ObjectType.custom: 'custom',
  ObjectType.shop: 'shop',
};
