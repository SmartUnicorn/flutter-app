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
import 'package:test_new/mobikul/models/productDetail/prices.dart';

import 'attributes.dart';
import 'option_prices.dart';
part 'configurable_data.g.dart';


@JsonSerializable()
class ConfigurableData{

  List<Attributes>? attributes;
  String? template;
  List<OptionPrices>? optionPrices;
  Prices? prices;
  String? id;
  String? chooseText;
  String? images;
  String? index;
  String? swatchData;

  ConfigurableData(
      this.attributes,
      this.template,
      this.optionPrices,
      this.prices,
      this.id,
      this.chooseText,
      this.images,
      this.index,
      this.swatchData);

  factory ConfigurableData.fromJson(Map<String, dynamic> json) =>
      _$ConfigurableDataFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigurableDataToJson(this);

}