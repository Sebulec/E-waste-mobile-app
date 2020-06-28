// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsDto _$NewsDtoFromJson(Map<String, dynamic> json) {
  return NewsDto(
    json['id'] as int,
    json['header'] as String,
    json['user'] == null
        ? null
        : _NewsUser.fromJson(json['user'] as Map<String, dynamic>),
    json['text'] as String,
    const CustomDateTimeConverter().fromJson(json['created_at'] as String),
    json['image'] == null
        ? null
        : _Image.fromJson(json['image'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NewsDtoToJson(NewsDto instance) => <String, dynamic>{
      'id': instance.id,
      'header': instance.header,
      'user': instance.user,
      'text': instance.text,
      'image': instance.image,
      'created_at': const CustomDateTimeConverter().toJson(instance.date),
    };

_NewsUser _$_NewsUserFromJson(Map<String, dynamic> json) {
  return _NewsUser(
    json['displayed_username'] as String,
  );
}

Map<String, dynamic> _$_NewsUserToJson(_NewsUser instance) => <String, dynamic>{
      'displayed_username': instance.username,
    };

_Image _$_ImageFromJson(Map<String, dynamic> json) {
  return _Image(
    json['url'] as String,
  );
}

Map<String, dynamic> _$_ImageToJson(_Image instance) => <String, dynamic>{
      'url': instance.url,
    };
