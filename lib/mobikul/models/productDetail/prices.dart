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

import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/mobikul/models/productDetail/price.dart';
part 'prices.g.dart';



@JsonSerializable()
class Prices{
  Price? oldPrice;
  Price? basePrice;
  Price? finalPrice;

  Prices(this.oldPrice, this.basePrice, this.finalPrice);

  factory Prices.fromJson(Map<String, dynamic> json) =>
      _$PricesFromJson(json);

  Map<String, dynamic> toJson() => _$PricesToJson(this);
}