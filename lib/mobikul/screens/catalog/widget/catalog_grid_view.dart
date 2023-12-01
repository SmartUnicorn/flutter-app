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

import 'package:flutter/material.dart';
import 'package:test_new/mobikul/models/categoryPage/product_tile_data.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/PreCacheApiHelper.dart';
import '../../../models/productDetail/product_detail_page_model.dart';
import '../../../network_manager/api_client.dart';
import 'item_catalog_product_grid.dart';

class CatalogGridView extends StatelessWidget {
  const CatalogGridView({Key? key, this.products, this.controller})
      : super(key: key);

  final List<ProductTileData>? products;
  final ScrollController? controller;

  int getListLength() {
    if (products == null) {
      return 0;
    } else {
      return products?.length.isEven == true
          ? products?.length ?? 0
          : products?.length ?? 0 + 1;
    }
  }


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
      ),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: getListLength(),
      controller: controller,
      itemBuilder: (context, index) {
        //mobikul  pre-cache
        if (!(mainBox.containsKey("ProductPageData:" + products![index].entityId.toString() ?? ""))) {
          precCacheProductPage(products![index].entityId.toString() ?? "");
        }        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.productPage,
              arguments: getProductDataAttributeMap(
                products![index].name ?? "",
                products![index].entityId.toString() ?? "",
              ),
            );
          },
          child: ItemCatalogProductGrid(
            product: products![index],
            imageSize: (AppSizes.deviceWidth -
                (AppSizes.size8 + AppSizes.size8)) /
                2.5,
            isSelected: false,
          ),
        );
      },
    );
  }
}
