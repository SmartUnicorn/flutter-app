// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_pay_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuickPayModel _$QuickPayModelFromJson(Map<String, dynamic> json) =>
    QuickPayModel(
      success: json['success'] as bool?,
      url: json['url'] as String?,
      successUrl: json['successUrl'] as String?,
      cancelUrl: json['cancelUrl'] as String?,
      failureUrl: json['failureUrl'] as String?,
    );

Map<String, dynamic> _$QuickPayModelToJson(QuickPayModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'url': instance.url,
      'successUrl': instance.successUrl,
      'cancelUrl': instance.cancelUrl,
      'failureUrl': instance.failureUrl,
    };
