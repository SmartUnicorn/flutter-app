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

import '../../../constants/app_constants.dart';
import '../../../constants/app_string_constant.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/utils.dart';
import '../../../models/order_details/order_detail_model.dart';

Widget orderIdContainer(BuildContext context, OrderDetailModel? orderModel, AppLocalizations? localization) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSizes.paddingMedium),
          topRight: Radius.circular(AppSizes.paddingMedium)),
    ),
    padding: const EdgeInsets.symmetric(horizontal: AppSizes.size8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSizes.paddingMedium,
        ),
        Text(
          '${localization?.translate(AppStringConstant.orderId)} #${orderModel?.incrementId}',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(
              // color: AppColors.textColorSecondary,
              fontSize: AppSizes.textSizeMedium),
        ),
        const SizedBox(
          height: AppSizes.paddingMedium,
        ),
        const Divider(
          thickness: 1,
          height: 1,
        ),
      ],
    ),
  );
}

Widget orderPlaceDateContainer(BuildContext context, OrderDetailModel? orderModel, AppLocalizations? localization) {
  return Container(
      color: Theme.of(context).cardColor,
      width: AppSizes.deviceWidth,
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.paddingMedium, horizontal: AppSizes.size8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localization?.translate(AppStringConstant.placedOn)??"",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(
                    // color: AppColors.textColorSecondary,
                    fontSize: AppSizes.textSizeSmall),
              ),
              const SizedBox(
                height: AppSizes.linePadding,
              ),
              Text(
                orderModel?.orderDate ?? "",
                style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(
                    // color: AppColors.textColorPrimary,
                  fontSize: AppSizes.textSizeMedium),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.spacingGeneric,
                vertical: AppSizes.spacingTiny),
            decoration: BoxDecoration(
                color: Utils.orderStatusBackground(orderModel!.state.toString(), orderModel.statusColorCode.toString()),
                borderRadius: BorderRadius.circular(4)),
            child: Text(
              orderModel.statusLabel?.toUpperCase() ?? "",
              style: const TextStyle(color: AppColors.white, fontSize: AppSizes.textSizeSmall),
            ),
          ),

        ],
      ));
}