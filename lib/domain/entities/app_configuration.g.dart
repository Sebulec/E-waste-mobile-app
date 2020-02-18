// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfiguration _$AppConfigurationFromJson(Map<String, dynamic> json) {
  return AppConfiguration(
    json['IOS_minimum_version'] as int,
    json['Android_minimum_version'] as int,
  );
}

Map<String, dynamic> _$AppConfigurationToJson(AppConfiguration instance) =>
    <String, dynamic>{
      'IOS_minimum_version': instance.IOS_minimum_version,
      'Android_minimum_version': instance.Android_minimum_version,
    };
