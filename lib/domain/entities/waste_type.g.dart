// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waste_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WasteType _$WasteTypeFromJson(Map<String, dynamic> json) {
  return WasteType(
    json['name'] as String,
    _$enumDecodeNullable(_$WasteTypeEnumEnumMap, json['type']),
  );
}

Map<String, dynamic> _$WasteTypeToJson(WasteType instance) => <String, dynamic>{
      'name': instance.name,
      'type': _$WasteTypeEnumEnumMap[instance.type],
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

const _$WasteTypeEnumEnumMap = {
  WasteTypeEnum.energyEfficientBulbs: 'energyEfficientBulbs',
  WasteTypeEnum.batteries: 'batteries',
  WasteTypeEnum.smallElectronics: 'smallElectronics',
  WasteTypeEnum.largeElectronics: 'largeElectronics',
};
