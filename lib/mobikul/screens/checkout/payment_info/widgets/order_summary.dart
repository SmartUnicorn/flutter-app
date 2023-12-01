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
import 'package:test_new/mobikul/app_widgets/image_view.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/app_localizations.dart';
import 'package:test_new/mobikul/models/cart/cart_item.dart';

Widget orderSummary(BuildContext context, AppLocalizations? _localization,
    List<CartItem> items) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSizes.size12),
    child: Container(
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.size8),
            child: Text(
                _localization?.translate(AppStringConstant.orderSummary) ?? "",
                style: Theme.of(context).textTheme.headline3),
          ),
          const Divider(
            thickness: 1,
            height: 1,
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var data = items[index];
                return buildItems(data, context, _localization);
              }),
        ],
      ),
    ),
  );
}

Widget buildItems(
    CartItem item, BuildContext context, AppLocalizations? _localization) {
  return Container(
    margin: EdgeInsets.fromLTRB(8,8,8,0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
        border: Border.all(
      color: Theme.of(context).dividerColor,
    )),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Stack(children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ImageView(
                fit: BoxFit.fill,
                url: item.thumbnail,
                height: (AppSizes.deviceWidth / 3),
                width: (AppSizes.deviceWidth / 3),
              ),
            ),
            // Positioned(
            //     left: 10,
            //     bottom: 10,
            //     child: Icon(
            //       Icons.info,
            //       color: AppColors.lightGray,
            //     ))
          ]),
        ),
    // Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: ClipRRect(
    //   borderRadius: BorderRadius.circular(10),
    //   child: ImageView(
    //     url: item.thumbnail,
    //     width: (AppSizes.deviceWidth / 3),
    //     height: (AppSizes.deviceWidth / 3),
    //   )),
    // ),
        const SizedBox(
          width: AppSizes.size8,
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 2.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: AppSizes.linePadding),
                child: Text(item.productName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline3),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: AppSizes.linePadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${_localization?.translate(AppStringConstant.price) ?? ""}: ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 15),
                    ),
                    Text(
                      item.price,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(fontWeight: FontWeight.bold),
                    )
                    // Text(
                    //     (item.priceReduce ?? '').isNotEmpty
                    //         ? item.priceReduce ?? ''
                    //         : item.priceUnit ?? '',
                    //     style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold)
                    // ),
                    // Visibility(
                    //     visible:
                    //     (item.priceReduce ?? '').isNotEmpty,
                    //     child: Row(
                    //       children: [
                    //         const SizedBox(
                    //           width: AppSizes.linePadding,
                    //         ),
                    //         Text(item.priceUnit ?? '',
                    //             style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold)
                    //         ),
                    //       ],
                    //     )),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: AppSizes.linePadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${_localization?.translate(AppStringConstant.qty) ?? ""}: ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 15),
                    ),
                    Text((item.qty?.toInt()).toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: AppSizes.linePadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${_localization?.translate(AppStringConstant.subtotal) ?? ""}: ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 15),
                    ),
                    Text(item.subTotal ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
