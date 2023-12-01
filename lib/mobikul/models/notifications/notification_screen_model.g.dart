// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_screen_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationScreenModel _$NotificationScreenModelFromJson(
        Map<String, dynamic> json) =>
    NotificationScreenModel(
      notificationList: (json['notificationList'] as List<dynamic>?)
          ?.map((e) => Notifications.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as int?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = json['cartCount'] as int?;

Map<String, dynamic> _$NotificationScreenModelToJson(
        NotificationScreenModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'notificationList': instance.notificationList,
      'error': instance.error,
    };

Notifications _$NotificationsFromJson(Map<String, dynamic> json) =>
    Notifications(
      id: json['id'] as String?,
      productId: json['productId'] as String?,
      title: json['title'] as String?,
      banner: json['banner'] as String?,
      dominantColor: json['dominantColor'] as String?,
      notificationType: json['notificationType'] as String?,
      content: json['content'] as String?,
      subTitle: json['subTitle'] as String?,
    );

Map<String, dynamic> _$NotificationsToJson(Notifications instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'title': instance.title,
      'banner': instance.banner,
      'dominantColor': instance.dominantColor,
      'notificationType': instance.notificationType,
      'content': instance.content,
      'subTitle': instance.subTitle,
    };
