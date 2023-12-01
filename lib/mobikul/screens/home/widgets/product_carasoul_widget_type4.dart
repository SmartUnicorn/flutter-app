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
import 'package:test_new/mobikul/models/categoryPage/product_tile_data.dart';
import 'package:test_new/mobikul/screens/home/bloc/home_screen_bloc.dart';
import 'package:test_new/mobikul/screens/home/widgets/home_page_product_card.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/arguments_map.dart';
import '../../category/widgets/view_all.dart';

Widget ProductCarasoulype4(List<ProductTileData> products, BuildContext context,
    String id, String title, HomeScreenBloc homeScreenBloc) {
  var totalWidth = AppSizes.deviceWidth - ((AppSizes.size8 + AppSizes.size8));
  var totalHeight = AppSizes.deviceHeight / 1.4;
  var imageHeight = (AppSizes.deviceHeight) / 1.9;

  return Container(
    color: Theme.of(context).cardColor,
    child: Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: AppSizes.size14)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: AppSizes.size8),
              child: Container(
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
            ),
            Padding(
              padding: const EdgeInsets.only(right: AppSizes.size8),
              child: viewAllButton(context, () {
                Navigator.pushNamed(context, AppRoutes.catalog,
                    arguments: getCatalogMap(
                      id,
                      title ?? "",
                      BUNDLE_KEY_CATALOG_TYPE_CUSTOM_CAROUSEL,
                      false,
                    ));
              }),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: AppSizes.size14)),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: AppSizes.size8),
              child: SizedBox(
                width: totalWidth * 0.55,
                child: Column(
                  children: [
                    SizedBox(
                      height: (totalHeight / 1.8) + 24,
                      child: HomePageProductCard(
                        product: products[0],
                        imageSize: imageHeight * 0.5,
                      ),
                    ),
                    SizedBox(
                      height: (totalHeight / 1.8) + 24,
                      child: HomePageProductCard(
                        product: products[1],
                        imageSize: imageHeight * 0.5,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: totalWidth * 0.45,
              child: Column(
                children: [
                  SizedBox(
                    height: (totalHeight / 2.7) + 16,
                    child: HomePageProductCard(
                      product: products[2],
                      imageSize: imageHeight / 3.5,
                    ),
                  ),
                  SizedBox(
                    height: (totalHeight / 2.7) + 16,
                    child: HomePageProductCard(
                      product: products[3],
                      imageSize: imageHeight / 3.5,
                    ),
                  ),
                  SizedBox(
                    height: (totalHeight / 2.7) + 16,
                    child: HomePageProductCard(
                      product: products[4],
                      imageSize: imageHeight / 3.5,
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ],
    ),
  );
}
