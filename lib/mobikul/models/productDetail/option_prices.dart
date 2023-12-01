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

part 'option_prices.g.dart';

@JsonSerializable()
class OptionPrices{
  Price? oldPrice;
  Price? basePrice;
  Price? finalPrice;
  Price? tierPrices;
  int? product;

  OptionPrices(this.oldPrice, this.basePrice, this.finalPrice, this.tierPrices,
      this.product);

  factory OptionPrices.fromJson(Map<String, dynamic> json) =>
      _$OptionPricesFromJson(json);

  Map<String, dynamic> toJson() => _$OptionPricesToJson(this);
}