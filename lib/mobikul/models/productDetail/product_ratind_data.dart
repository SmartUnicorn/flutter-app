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
part 'product_ratind_data.g.dart';

@JsonSerializable()
class ProductRatingData{

  String? label;
  String? value;

  ProductRatingData(this.label, this.value);

  factory ProductRatingData.fromJson(Map<String, dynamic> json) =>
      _$ProductRatingDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductRatingDataToJson(this);
}