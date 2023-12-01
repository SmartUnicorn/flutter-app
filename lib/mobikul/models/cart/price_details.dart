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

part 'price_details.g.dart';

@JsonSerializable()
class PriceDetails {
  @JsonKey(name:"title")
  String? title;

  @JsonKey(name:"value")
  String? value;


  PriceDetails({this.title, this.value});

  factory PriceDetails.fromJson(Map<String, dynamic> json) =>
      _$PriceDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$PriceDetailsToJson(this);
}
