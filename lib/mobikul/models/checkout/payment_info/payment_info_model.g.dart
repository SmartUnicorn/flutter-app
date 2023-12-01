// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentInfoModel _$PaymentInfoModelFromJson(Map<String, dynamic> json) =>
    PaymentInfoModel(
      orderReviewData: json['orderReviewData'] == null
          ? null
          : OrderReviewData.fromJson(
              json['orderReviewData'] as Map<String, dynamic>),
      cartCount: json['cartCount'] as int?,
      billingAddress: json['billingAddress'] as String?,
      couponCode: json['couponCode'] as String?,
      currencyCode: json['currencyCode'] as String?,
      paymentMethods: (json['paymentMethods'] as List<dynamic>?)
          ?.map((e) => PaymentMethods.fromJson(e as Map<String, dynamic>))
          .toList(),
      shippingAddress: json['shippingAddress'] as String?,
      shippingMethod: json['shippingMethod'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..total = json['cartTotal'] as String?;

Map<String, dynamic> _$PaymentInfoModelToJson(PaymentInfoModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'billingAddress': instance.billingAddress,
      'shippingAddress': instance.shippingAddress,
      'shippingMethod': instance.shippingMethod,
      'couponCode': instance.couponCode,
      'currencyCode': instance.currencyCode,
      'orderReviewData': instance.orderReviewData,
      'paymentMethods': instance.paymentMethods,
      'cartCount': instance.cartCount,
      'cartTotal': instance.total,
    };

OrderReviewData _$OrderReviewDataFromJson(Map<String, dynamic> json) =>
    OrderReviewData(
      cartTotal: json['cartTotal'] as int?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totals: (json['totals'] as List<dynamic>?)
          ?.map((e) => PriceDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderReviewDataToJson(OrderReviewData instance) =>
    <String, dynamic>{
      'items': instance.items,
      'totals': instance.totals,
      'cartTotal': instance.cartTotal,
    };

PaymentMethods _$PaymentMethodsFromJson(Map<String, dynamic> json) =>
    PaymentMethods(
      code: json['code'] as String?,
      title: json['title'] as String?,
      extraInformation: json['extraInformation'] as String?,
    );

Map<String, dynamic> _$PaymentMethodsToJson(PaymentMethods instance) =>
    <String, dynamic>{
      'code': instance.code,
      'title': instance.title,
      'extraInformation': instance.extraInformation,
    };
