import 'package:e_waste/domain/helpers/custom_datetime.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class News {
  final String id;
  final String title;
  final String author;
  final String text;
  final DateTime date;

  News(this.id, this.title, this.author, this.text, this.date);
  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}
