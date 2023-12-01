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
import 'package:test_new/mobikul/models/productDetail/swatch_data.dart';
part 'product_attributes_options.g.dart';

@JsonSerializable()
class ProductAttributeOption{
  int? id;
  String? label;
  List<String>? products;
  SwatchData? swatchData;

  ProductAttributeOption(this.id, this.label, this.products);

  factory ProductAttributeOption.fromJson(Map<String, dynamic> json) =>
      _$ProductAttributeOptionFromJson(json);

  Map<String, dynamic> toJson() => _$ProductAttributeOptionToJson(this);
}