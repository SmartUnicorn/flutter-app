// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cms_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CmsData _$CmsDataFromJson(Map<String, dynamic> json) => CmsData(
      id: json['id'] as String?,
      title: json['title'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = json['cartCount'] as int?;

Map<String, dynamic> _$CmsDataToJson(CmsData instance) => <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'id': instance.id,
      'title': instance.title,
    };
