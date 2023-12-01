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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/mobikul/configuration/mobikul_theme.dart';

import '../../../app_widgets/image_view.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_string_constant.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/bottom_sheet_helper.dart';
import '../../../models/order_details/order_detail_model.dart';
import '../../add_review/add_review_screen.dart';
import '../../add_review/bloc/add_review_screen_bloc.dart';
import '../../add_review/bloc/add_review_screen_repository.dart';
import 'option_details.dart';

Widget orderItemCard(
    OrderItem item, BuildContext context, AppLocalizations? localization) {
  return Container(
    padding: const EdgeInsets.only(top: AppSizes.paddingNormal),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 10, 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Stack(children: <Widget>[
              SizedBox(
                height: (AppSizes.deviceWidth / 3),
                width: (AppSizes.deviceWidth / 3),
                child: ImageView(
                  url: item.image,
                ),
              ),
              if (item.options != null)
                Positioned(
                    right: 78,
                    top: 97,
                    child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (ctx) => OptionDetails(
                              item,
                            ),
                          );
                        },
                        icon: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Icon(Icons.info_outline))))
            ]),
          ),
          const SizedBox(
            width: AppSizes.size12,
          ),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSizes.size8,
                  ),
                  child: Text(item.name ?? '',
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline3
                      // ?.copyWith(fontSize: AppSizes.textSizeMedium, color: AppColors.textColorPrimary)
                      ),
                ),
                item.options != null
                    ? const SizedBox(
                        height: AppSizes.spacingTiny,
                      )
                    : Container(),
                item.options != null
                    ? itemDetailView(
                        '${localization?.translate(AppStringConstant.size)}',
                        "${item.options ?? "L"}",
                        context)
                    : Container(),
                item.options != null
                    ? const SizedBox(
                        height: AppSizes.spacingTiny,
                      )
                    : Container(),
                item.options != null
                    ? itemDetailView(
                        '${localization?.translate(AppStringConstant.color)}',
                        "${item.options ?? "red"}",
                        context)
                    : Container(),
                item.options != null
                    ? const SizedBox(
                        height: AppSizes.spacingTiny,
                      )
                    : Container(),
                item.options != null
                    ? itemDetailView(
                        '${localization?.translate(AppStringConstant.qty)}',
                        '${item.qty?.ordered ?? "5"}',
                        context)
                    : Container(),
                item.options != null
                    ? const SizedBox(
                        height: AppSizes.spacingTiny,
                      )
                    : Container(),
                item.options != null
                    ? itemDetailView(
                        '${localization?.translate(AppStringConstant.shippedColon)}',
                        '${item.qty?.shipped ?? "2"}',
                        context)
                    : Container(),
                const SizedBox(
                  height: AppSizes.spacingTiny,
                ),
                itemDetailView(
                    '${localization?.translate(AppStringConstant.price)}',
                    item.price ?? '',
                    context),
                const SizedBox(
                  height: AppSizes.spacingTiny,
                ),
                itemDetailView(
                    '${localization?.translate(AppStringConstant.subtotal)}',
                    item.subTotal ?? '',
                    context),
                const SizedBox(
                  height: AppSizes.spacingGeneric,
                ),
                itemAddReview(() {
                  reviewBottomModalSheet(context, item.name ?? '',
                      item.image ?? '', item.productId ?? "", []);
                }, '${localization?.translate(AppStringConstant.writeReview)}',
                    context),
                const SizedBox(
                  height: AppSizes.size8,
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget itemDetailView(String key, String value, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(
        top: AppSizes.linePadding, left: AppSizes.linePadding),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(key, style: Theme.of(context).textTheme.bodyMedium
              // ?.apply(color: AppColors.textColorSecondary)
              // ?.copyWith(fontSize: AppSizes.textSizeSmall, color: AppColors.textColorSecondary)
              ),
        ),
        const SizedBox(
          width: 14.0,
        ),
        Expanded(
            flex: 1,
            child: Text("-", style: Theme.of(context).textTheme.bodyMedium
                // ?.copyWith(fontSize: AppSizes.textSizeSmall, color: AppColors.textColorPrimary)
                )),
        Expanded(
          flex: 1,
          child: Text(value, style: Theme.of(context).textTheme.headline3
              // ?.apply(/*fontSize: AppSizes.textSizeSmall*/ color: AppColors.textColorPrimary)
              ),
        ),
      ],
    ),
  );
}

Widget itemAddReview(
    VoidCallback callback, String title, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0.0),
    child: Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spacingLarge, vertical: AppSizes.spacingGeneric),
      child: ElevatedButton(
        onPressed: callback,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            const Icon(
              Icons.rate_review_outlined,
              size: AppSizes.size16,
              color: AppColors.white,
            ),
            const SizedBox(
              width: AppSizes.size4,
            ),
            Text((title.toUpperCase() ?? ''),
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.textSizeMedium,
                    color: AppColors.white))
          ],
        ),
      ),
    ),
  );
}
