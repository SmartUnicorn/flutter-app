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
import 'package:test_new/mobikul/models/categoryPage/banner_images.dart';
import 'package:test_new/mobikul/models/categoryPage/product_tile_data.dart';
import 'package:test_new/mobikul/models/homePage/featured_categories.dart';

import 'home_page_banner.dart';
part 'home_page_carausel.g.dart';

@JsonSerializable()
class Carousel {
  String? id;
  String? type;
  String? label;
  String? color;
  String? image;
  List<ProductTileData>? productList;
  List<Banners>? banners;
  List<FeaturedCategories>? featuredCategories;


  Carousel({this.id, this.type, this.label, this.color, this.image,
      this.productList, this.banners, this.featuredCategories});

  factory Carousel.fromJson(Map<String, dynamic> json) =>
    _$CarouselFromJson(json);


  Map<String, dynamic> toJson() => _$CarouselToJson(this);
}