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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_string_constant.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/PreCacheApiHelper.dart';
import '../../../helper/utils.dart';
import '../../../models/catalog/request/catalog_product_request.dart';
import '../../../models/categoryPage/product_tile_data.dart';
import '../../category/widgets/category_products.dart';
import '../../category/widgets/view_all.dart';
import 'category_widget_type1.dart';
import 'item_card.dart';

Widget ProductCarasoulType2(List<ProductTileData> products,
    BuildContext context, String id, String title,
    {bool isShowViewAll = true, Function? callBack}) {

  //mobikul  pre-cache
  Map<String,String>? sort =  Map<String,String>();
  var req = CatalogProductRequest(page: 1, id: id, type: BUNDLE_KEY_CATALOG_TYPE_CUSTOM_CAROUSEL,sortData: sort,filterData: []);
  preCacheGetCatalogProducts(req);
  return Visibility(
    visible: products.isNotEmpty,
    child: Container(
      width: MediaQuery.of(context).size.width/1,
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0,left:10.0,right:10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSizes.size8 / 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.size8 / 2),
                  ),
                  child: Text(
                    title.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1,
                  ),
                ),
                if (isShowViewAll)
                  viewAllButton(context, () {

                    Navigator.pushNamed(context, AppRoutes.catalog,
                        arguments: getCatalogMap(
                          id ?? "",
                          title ?? "",
                          BUNDLE_KEY_CATALOG_TYPE_CUSTOM_CAROUSEL,
                          false,
                        ));
                  }),
              ],
            ),
          ),
          const SizedBox(
            height: AppSizes.size8,
          ),
          SizedBox(
            width: AppSizes.deviceWidth.toDouble(),
            height: (callBack != null)
                ? ((AppSizes.deviceWidth / 1.4) + 15)
                : ((AppSizes.deviceWidth / 1.6) + 15),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = products[index];
                  if (!(mainBox.containsKey("ProductPageData:" + (data.entityId ?? 0).toString() ?? ""))) {
                    precCacheProductPage((data.entityId ?? 0).toString() ?? "");

                  }
                  // precCacheProductPage((data.entityId ?? 0).toString());
                  return GestureDetector(
                    onTap: () {},
                    child: ItemCard(
                      product: data,
                      imageSize: (AppSizes.deviceWidth -
                              (AppSizes.size8 + AppSizes.size8)) /
                          2.5,
                      isSelected: false,
                      callBack: callBack,
                    ),
                  );
                }),
          ),
        ],
      ),
    ),
  );
}
