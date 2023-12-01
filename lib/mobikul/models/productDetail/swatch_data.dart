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
import 'package:test_new/mobikul/models/productDetail/product_attributes_options.dart';
part 'swatch_data.g.dart';

@JsonSerializable()
class SwatchData{

  int? id;
  String? type;
  String? value;
  int? position;
  bool? isSelected;
  bool? isEnabled;

  SwatchData(
      {this.id,
      this.type,
      this.value,
      this.position,
      this.isSelected,
      this.isEnabled});

  factory SwatchData.fromJson(Map<String, dynamic> json) =>
      _$SwatchDataFromJson(json);

  Map<String, dynamic> toJson() => _$SwatchDataToJson(this);

}