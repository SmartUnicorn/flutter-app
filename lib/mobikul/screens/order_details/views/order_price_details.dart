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
import 'order_heading_view.dart';


Widget orderPriceDetails(OrderDetailModel model, BuildContext context,
    AppLocalizations? localizations) {
  return orderHeaderLayout(
      context,
      localizations?.translate(AppStringConstant.priceDetails) ?? "",
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.size10),
        child: Column(
          children:
            (model.orderData?.totals??[]).map((e) => orderPriceDetailsItem(
                e.label ?? "",
                e.formattedValue??"",
                context)).toList(),
        ),
      ));
}

Widget orderPriceDetailsItem(String key, String value, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSizes.size8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          key,
          style: Theme.of(context).textTheme.bodyMedium!.apply()
          // ?.apply(color: AppColors.textColorSecondary),
        ),
        Text(value, style: Theme.of(context).textTheme.headline3
            // ?.apply(color: AppColors.textColorPrimary),
          ),
      ],
    ),
  );
}
