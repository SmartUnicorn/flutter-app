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
part 'add_to_cart_response.g.dart';

@JsonSerializable()
class AddToCartResponse extends BaseModel{
  int? quoteId;
  bool? isVirtual;
  double? minimumAmount;
  String? minimumFormattedAmount;
  bool? isCheckoutAllowed;
  String? descriptionMessage;
  bool? isAllowedGuestCheckout;
  bool? canGuestCheckoutDownloadable;
  double? cartTotal;
  String? cartTotalFormattedAmount;


  AddToCartResponse(
      {this.quoteId,
      this.isVirtual,
      this.minimumAmount,
      this.minimumFormattedAmount,
      this.isCheckoutAllowed,
      this.descriptionMessage,
      this.isAllowedGuestCheckout,
      this.canGuestCheckoutDownloadable,
      this.cartTotal,
      this.cartTotalFormattedAmount
      });


  factory AddToCartResponse.fromJson(Map<String, dynamic> json) =>
      _$AddToCartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddToCartResponseToJson(this);
}