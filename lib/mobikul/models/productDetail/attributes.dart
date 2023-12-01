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
part 'attributes.g.dart';

@JsonSerializable()
class Attributes{

  String? code;
  int? id;
  String? label;
  List<ProductAttributeOption>? options;
  String? position;
  String? swatchData;
  String? swatchType;
  bool? updateProductPreviewImage;

  Attributes(this.code, this.id, this.label, this.options, this.position,
      this.swatchData, this.swatchType, this.updateProductPreviewImage);

  factory Attributes.fromJson(Map<String, dynamic> json) =>
      _$AttributesFromJson(json);

  Map<String, dynamic> toJson() => _$AttributesToJson(this);

}