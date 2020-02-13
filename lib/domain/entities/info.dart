import 'package:json_annotation/json_annotation.dart';

part 'info.g.dart';

@JsonSerializable()
class Info {
  final String htmlText;

  Info(this.htmlText);
}
