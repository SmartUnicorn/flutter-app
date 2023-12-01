// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swatch_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SwatchData _$SwatchDataFromJson(Map<String, dynamic> json) => SwatchData(
      id: json['id'] as int?,
      type: json['type'] as String?,
      value: json['value'] as String?,
      position: json['position'] as int?,
      isSelected: json['isSelected'] as bool?,
      isEnabled: json['isEnabled'] as bool?,
    );

Map<String, dynamic> _$SwatchDataToJson(SwatchData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'value': instance.value,
      'position': instance.position,
      'isSelected': instance.isSelected,
      'isEnabled': instance.isEnabled,
    };
