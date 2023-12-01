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
part 'featured_categories.g.dart';

@JsonSerializable()
class FeaturedCategories{

  String? url;
  String? dominantColor;
  String? categoryName;
  int? categoryId;


  FeaturedCategories(
  {this.url, this.dominantColor, this.categoryName, this.categoryId});

  factory FeaturedCategories.fromJson(Map<String, dynamic> json) =>
      _$FeaturedCategoriesFromJson(json);

  Map<String, dynamic> toJson() => _$FeaturedCategoriesToJson(this);
}