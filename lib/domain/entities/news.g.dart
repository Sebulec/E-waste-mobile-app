// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) {
  return News(
    json['id'] as String,
    json['title'] as String,
    json['author'] as String,
    json['text'] as String,
    const CustomDateTimeConverter().fromJson(json['date'] as String),
  );
}

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'text': instance.text,
      'date': const CustomDateTimeConverter().toJson(instance.date),
    };
