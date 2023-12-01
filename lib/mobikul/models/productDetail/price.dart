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
part 'price.g.dart';



@JsonSerializable()
class Price{
  dynamic? amount;

  Price(this.amount);

  factory Price.fromJson(Map<String, dynamic> json) =>
      _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);
}