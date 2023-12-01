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

import '../base_model.dart';
import '../productDetail/product_detail_page_model.dart';

part 'rating_form_data_model.g.dart';

@JsonSerializable()
class RatingFormDataModel extends BaseModel{

  List<RatingFormData>? ratingFormData;

  RatingFormDataModel(
      this.ratingFormData);

  factory RatingFormDataModel.fromJson(Map<String, dynamic> json) =>
      _$RatingFormDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatingFormDataModelToJson(this);

}