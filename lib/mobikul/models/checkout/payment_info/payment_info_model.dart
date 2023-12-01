/*
 *
 *  Webkul Software.
 * @package Mobikul Application Code.
 *  @Category Mobikul
 *  @author Webkul <support@webkul.com>
 *  @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *  @license https://store.webkul.com/license.html
 *  @link https://store.webkul.com/license.html
 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/mobikul/models/base_model.dart';
import 'package:test_new/mobikul/models/cart/cart_item.dart';
import 'package:test_new/mobikul/models/cart/price_details.dart';

part 'payment_info_model.g.dart';

@JsonSerializable()
class PaymentInfoModel extends BaseModel{
  @JsonKey(name: "billingAddress")
  String? billingAddress;

  @JsonKey(name: "shippingAddress")
  String? shippingAddress;

  @JsonKey(name: "shippingMethod")
  String? shippingMethod;

  @JsonKey(name: "couponCode")
  String? couponCode;

  @JsonKey(name: "currencyCode")
  String? currencyCode;

  @JsonKey(name: "orderReviewData")
  OrderReviewData? orderReviewData;

  @JsonKey(name: "paymentMethods")
  List<PaymentMethods>? paymentMethods;

  @JsonKey(name: "cartCount")
  int? cartCount;

  @JsonKey(name:"cartTotal")
  String? total;

  PaymentInfoModel({this.orderReviewData, this.cartCount, this.billingAddress, this.couponCode, this.currencyCode, this.paymentMethods, this.shippingAddress, this.shippingMethod});

  factory PaymentInfoModel.fromJson(Map<String, dynamic> json) => _$PaymentInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentInfoModelToJson(this);
}

@JsonSerializable()
class OrderReviewData{
  @JsonKey(name: "items")
  List<CartItem>? items;

  @JsonKey(name: "totals")
  List<PriceDetails>? totals;

  @JsonKey(name: "cartTotal")
  int? cartTotal;

  OrderReviewData({this.cartTotal, this.items, this.totals});

  factory OrderReviewData.fromJson(Map<String, dynamic> json) => _$OrderReviewDataFromJson(json);

  Map<String, dynamic> toJson() => _$OrderReviewDataToJson(this);


}

@JsonSerializable()
class PaymentMethods{
  @JsonKey(name: "code")
  String? code;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "extraInformation")
  String? extraInformation;

  PaymentMethods({this.code, this.title, this.extraInformation});

  factory PaymentMethods.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodsFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodsToJson(this);
}