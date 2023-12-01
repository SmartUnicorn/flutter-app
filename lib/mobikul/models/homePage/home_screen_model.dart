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
import 'package:test_new/mobikul/models/categoryPage/category.dart';
import 'package:test_new/mobikul/models/homePage/home_page_language.dart';
import 'package:test_new/mobikul/models/homePage/sort_order.dart';
import 'package:test_new/mobikul/models/homePage/website_data.dart';

import '../base_model.dart';
import '../productDetail/price_format.dart';
import 'cms_data.dart';
import 'featured_categories.dart';
import 'footer_menu.dart';
import 'home_page_banner.dart';
import 'home_page_carausel.dart';
import 'home_page_currencies.dart';
import 'home_page_product.dart';
part 'home_screen_model.g.dart';

@JsonSerializable()
class HomePageData extends BaseModel {
  String? defaultCurrency;
  List<AllowedCurrencies>? allowedCurrencies;
  PriceFormat? priceFormat;
  List<Category>? categories;
  List<FeaturedCategories>? featuredCategories;
  List<Banners>? bannerImages;
  List<Carousel>? carousel;
  List<WebsiteData>? websiteData;
  List<LanguageData>? storeData;
  List<CmsData>? cmsData;


  String? wishlistEnable;
  String? customerName;
  String? customerEmail;

  int? themeType;
  String? tabCategoryView;


  String? productId;
  String? productName;
  String? categoryId;
  String? categoryName;

  @JsonKey(name: "sortOrder")
  List<SortOrder>? sortOrder;

  String? walkthroughVersion;

  String? appLogo;
  String? darkAppLogo;
  String? splashImage;
  String? darkSplashImage;
  dynamic websiteId;


  HomePageData(
      {this.defaultCurrency,
      this.allowedCurrencies,
      this.priceFormat,
      this.categories,
      this.featuredCategories,
      this.bannerImages,
      this.carousel,
      this.websiteData,
      this.storeData,
      // this.cmsData,
      this.wishlistEnable,
      this.customerName,
      this.customerEmail,
      this.themeType,
      this.tabCategoryView,
      this.productId,
      this.productName,
      this.categoryId,
      this.categoryName,
      this.sortOrder,
      this.walkthroughVersion,
      this.websiteId
      });


  factory HomePageData.fromJson(Map<String, dynamic> json) =>
      _$HomePageDataFromJson(json);

  Map<String, dynamic> toJson() => _$HomePageDataToJson(this);


}


















