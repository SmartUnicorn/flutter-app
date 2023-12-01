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
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/screens/category/widgets/view_card.dart';

import '../../../../main.dart';
import '../../../app_widgets/image_view.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/PreCacheApiHelper.dart';
import '../../../models/categoryPage/category.dart';
import '../../../network_manager/api_client.dart';

// ignore: must_be_immutable
class CategoryTile extends StatefulWidget {
  List<Category>? subCategories;

  CategoryTile({Key? key, this.subCategories}) : super(key: key);

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.subCategories?.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          //mobikul  pre-cache
          precCacheCategoryPage(widget.subCategories?[index].id ?? 0);
          if ((widget.subCategories?[index].childCategories ?? []).isEmpty) {
            //=============If no child's are found=========//
            return ListTile(
              title: Text(
                widget.subCategories?[index].name ?? "",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontSize: AppSizes.textSizeSmall),
              ),
              trailing: const Icon(Icons.arrow_right),
              onTap: () {
                Navigator.pushNamed(
                    navigatorKey.currentContext!, AppRoutes.catalog,
                    arguments: getCatalogMap(
                      widget.subCategories?[index].id.toString() ?? "",
                      widget.subCategories?[index].name ?? "",
                      BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
                      false,
                    ));
              },
            );
          }
          return ExpansionTile(
            //==========If sub category have child's=============//
              initiallyExpanded: false,
              title: Text(
                widget.subCategories?[index].name ?? "",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontSize: AppSizes.textSizeSmall),
              ),
              children: [
                if (widget.subCategories?[index].childCategories != null)
                  Container(child: expandedTileContent(index)),
              ]);
        });
  }

  //=========View after tile expansion===========//
  Widget expandedTileContent(int index) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: (1 - (80 / MediaQuery.of(context).size.width)),
        ),
        itemCount:
        (widget.subCategories?[index].childCategories?.length ?? 0) + 1,
        itemBuilder: (BuildContext context, int itemIndex) {
          //mobikul  pre-cache
          precCacheCategoryPage(widget.subCategories?[index].id ?? 0);
          if (itemIndex ==
              (widget.subCategories?[index].childCategories?.length ?? 0)) {
            return ViewCard(widget.subCategories?[index].id,
                widget.subCategories?[index].name ?? "");
          }
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.catalog,
                  arguments: getCatalogMap(
                    widget.subCategories?[index].childCategories?[itemIndex].id
                        .toString() ??
                        "",
                    widget.subCategories?[index].childCategories?[itemIndex]
                        .name ??
                        "",
                    BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
                    false,
                  ));
            },
            child: Column(
              children: [
                Container(
                  height: AppSizes.deviceWidth / 7,
                  width: AppSizes.deviceWidth / 7,
                  child: ImageView(url: widget.subCategories?[index].childCategories?[itemIndex].thumbnail ?? "",
                    fit: BoxFit.fill,),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                      widget.subCategories?[index].childCategories?[itemIndex]
                          .name ??
                          "",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(fontSize: AppSizes.textSizeSmall)),
                )
              ],
            ),
          );
        });
  }
}
