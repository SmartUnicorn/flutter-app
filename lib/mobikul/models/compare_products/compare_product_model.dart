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

import 'package:test_new/mobikul/models/categoryPage/product_tile_data.dart';

import '../base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'compare_product_model.g.dart';

@JsonSerializable()
class CompareProductModel extends BaseModel{
  @JsonKey(name:"showSwatchOnCollection")
  bool? showSwatchOnCollection;
  @JsonKey(name:"productList")
  List<ProductTileData>? productList;
  @JsonKey(name:"attributeValueList")
  List<AttributeValue>? attributeValueList;

  CompareProductModel({this.attributeValueList, this.productList, this.showSwatchOnCollection});

  factory CompareProductModel.fromJson(Map<String, dynamic> json) => _$CompareProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompareProductModelToJson(this);

}

@JsonSerializable()
class AttributeValue{
  @JsonKey(name: "attributeName")
  String? attributeName;
  @JsonKey(name:"value")
  List<String>? value;
AttributeValue({this.value, this.attributeName});

 factory AttributeValue.fromJson(Map<String, dynamic> json) => _$AttributeValueFromJson(json);

Map<String, dynamic> toJson() => _$AttributeValueToJson(this);
}
