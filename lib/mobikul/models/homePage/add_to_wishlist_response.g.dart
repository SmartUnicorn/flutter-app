// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_to_wishlist_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddToWishlistResponse _$AddToWishlistResponseFromJson(
        Map<String, dynamic> json) =>
    AddToWishlistResponse(
      itemId: json['itemId'] as int?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = json['cartCount'] as int?;

Map<String, dynamic> _$AddToWishlistResponseToJson(
        AddToWishlistResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'itemId': instance.itemId,
    };
