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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'dart:core';

import '../../../../main.dart';
import '../../../app_widgets/image_view.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/PreCacheApiHelper.dart';
import '../../../helper/utils.dart';
import '../../../models/catalog/request/catalog_product_request.dart';
import '../../../models/homePage/featured_categories.dart';
import 'category_widget_type1.dart';

Widget CategoryWidgetType2(
    BuildContext context, List<FeaturedCategories>? carousel) {
  return Container(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, AppSizes.size10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.size4 / 2),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(AppSizes.size4 / 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.size16),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Utils.getStringValue(
                        context, AppStringConstant.shopByCategory)
                        .toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1,
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppSizes.spacingTiny),
            child: Container(
              color: Theme.of(context).cardColor,
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      // childAspectRatio: (1 - (AppSizes.size30 / MediaQuery.of(context).size.width)),
                      mainAxisExtent: (MediaQuery.of(context).size.width/4) + 30
                  ),
                  itemCount: (carousel?.length ?? 0),
                  itemBuilder: (BuildContext context, int itemIndex) {
                    //mobikul  pre-cache
                    Map<String,String>? sort =  Map<String,String>();
                    var req = CatalogProductRequest(page: 1, id:  carousel?[itemIndex].categoryId.toString() ?? "", type: "category",sortData: sort,filterData: []);
                    preCacheGetCatalogProducts(req);
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.catalog,
                            arguments: getCatalogMap(
                              carousel?[itemIndex].categoryId.toString() ?? "",
                              carousel?[itemIndex].categoryName ?? "",
                              BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
                              false,
                            ));
                      },
                      child: Wrap(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: AppSizes.size4),
                                child: ClipOval(
                                    child: Image.network(
                                      carousel?[itemIndex].url ?? "",
                                      fit: BoxFit.cover,
                                      width: AppSizes.featuredCategoryImageSizeSmall,
                                      height: AppSizes.featuredCategoryImageSizeSmall,

                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: AppSizes.size8, left: AppSizes.spacingTiny, right: AppSizes.spacingTiny),
                                child: Text(carousel?[itemIndex].categoryName ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: AppSizes.textSizeTiny,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).brightness ==
                                        Brightness.dark
                                        ? Colors.white
                                        : Colors.grey[600],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          )
        ],
      ));
}
