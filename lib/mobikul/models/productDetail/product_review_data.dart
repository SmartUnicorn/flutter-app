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
import 'package:test_new/mobikul/models/productDetail/product_ratind_data.dart';
part 'product_review_data.g.dart';

@JsonSerializable()
class ProductReviewData{
  String? title;
  String? details;
  List<ProductRatingData>? ratings;
  String? reviewBy;
  String? reviewOn;

  ProductReviewData(
      this.title, this.details, this.ratings, this.reviewBy, this.reviewOn);

  factory ProductReviewData.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductReviewDataToJson(this);
  
  

}