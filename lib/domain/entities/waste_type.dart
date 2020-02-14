import 'package:json_annotation/json_annotation.dart';

part 'waste_type.g.dart';

@JsonSerializable()
class WasteType {
  final String name;
  final WasteTypeEnum type;

  WasteType(this.name, this.type);

  factory WasteType.fromJson(Map<String, dynamic> json) =>
      _$WasteTypeFromJson(json);
  Map<String, dynamic> toJson() => _$WasteTypeToJson(this);
}

enum WasteTypeEnum {
  energyEfficientBulbs,
  batteries,
  smallElectronics,
  largeElectronics
}

class WasteTypeEnumLocalized {
  final WasteTypeEnum _wasteTypeEnum;

  WasteTypeEnumLocalized(this._wasteTypeEnum);

  String localized() {
    switch (_wasteTypeEnum) {
      case WasteTypeEnum.energyEfficientBulbs:
        return "energyEfficientBulbs";
      case WasteTypeEnum.batteries:
        return "batteries";
      case WasteTypeEnum.smallElectronics:
        return "smallElectronics";
      case WasteTypeEnum.largeElectronics:
        return "largeElectronics";
    }
    return "";
  }
}
