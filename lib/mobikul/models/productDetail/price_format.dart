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
part 'price_format.g.dart';

@JsonSerializable()
class PriceFormat{
  String? pattern;
  int? precision;
  int? requiredPrecision;


  PriceFormat(this.pattern, this.precision, this.requiredPrecision);

  factory PriceFormat.fromJson(Map<String, dynamic> json) =>
      _$PriceFormatFromJson(json);

  Map<String, dynamic> toJson() => _$PriceFormatToJson(this);
}