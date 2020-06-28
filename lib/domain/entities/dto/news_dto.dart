import 'package:e_waste/domain/helpers/custom_datetime.dart';
import 'package:json_annotation/json_annotation.dart';

import '../news.dart';

part 'news_dto.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class NewsDto {
  final int id;
  final String header;
  final _NewsUser user;
  @JsonKey(name: "body")
  final String text;
  final _Image image;
  @JsonKey(name: "created_at")
  final DateTime date;

  NewsDto(this.id, this.header, this.user, this.text, this.date, this.image);
  factory NewsDto.fromJson(Map<String, dynamic> json) =>
      _$NewsDtoFromJson(json);
  Map<String, dynamic> toJson() => _$NewsDtoToJson(this);

  News asNews(String baseUrl) =>
      News(id, header, user.username, text, date, baseUrl + image.url);
}

@JsonSerializable()
class _NewsUser {
  @JsonKey(name: "displayed_username")
  final String username;
  _NewsUser(this.username);
  factory _NewsUser.fromJson(Map<String, dynamic> json) =>
      _$_NewsUserFromJson(json);
  Map<String, dynamic> toJson() => _$_NewsUserToJson(this);
}

@JsonSerializable()
class _Image {
  final String url;

  _Image(this.url);
  factory _Image.fromJson(Map<String, dynamic> json) => _$_ImageFromJson(json);
  Map<String, dynamic> toJson() => _$_ImageToJson(this);
}
