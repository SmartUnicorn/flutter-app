
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

import 'package:test_new/mobikul/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/mobikul/models/categoryPage/banner_images.dart';
import 'package:test_new/mobikul/models/categoryPage/category.dart';
import 'package:test_new/mobikul/models/categoryPage/product_tile_data.dart';
part 'category_page_response.g.dart';


@JsonSerializable()
class CategoryPageResponse extends BaseModel{

  List<Category>? categories;
  List<ProductTileData>? productList;
  List<ProductTileData>? hotSeller;
  List<BannerImages>? bannerImage;
  List<BannerImages>? smallBannerImage;

  CategoryPageResponse(this.categories, this.productList, this.hotSeller,
      this.bannerImage, this.smallBannerImage);

  factory CategoryPageResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryPageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryPageResponseToJson(this);
}
