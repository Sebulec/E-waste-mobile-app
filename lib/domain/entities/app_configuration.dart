import 'package:json_annotation/json_annotation.dart';

part 'app_configuration.g.dart';

@JsonSerializable()
class AppConfiguration {
  final int IOS_minimum_version;
  final int Android_minimum_version;

  AppConfiguration(this.IOS_minimum_version, this.Android_minimum_version);

  factory AppConfiguration.fromJson(Map<String, dynamic> json) =>
      _$AppConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$AppConfigurationToJson(this);
}
