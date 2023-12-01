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
import 'package:test_new/mobikul/helper/app_localizations.dart';

import '../../../app_widgets/image_view.dart';
import '../../../configuration/mobikul_theme.dart';
import '../../../constants/app_string_constant.dart';
import '../../../models/order_details/order_detail_model.dart';
import 'order_heading_view.dart';

Widget deliveryBoyInfo(BuildContext context, AppLocalizations? localizations,
    OrderDetailModel? orderModel) {
  return orderHeaderLayout(
      context,
      localizations?.translate(AppStringConstant.deliveryBoyDetails) ?? "",
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.spacingHuge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: AppSizes.spacingNormal,
            ),
            Text(
              orderModel?.deliveryBoys![0].products![0] ?? "",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: AppSizes.textSizeMedium,
                  color: AppColors.textColorPrimary),
            ),
            const SizedBox(
              height: AppSizes.spacingLarge,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 35,
                  child: ClipOval(
                      child: ImageView(
                    url: orderModel?.deliveryBoys![0].avatar ?? "",
                  )),
                ),
                const SizedBox(
                  height: AppSizes.spacingNormal,
                  width: AppSizes.spacingNormal,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      orderModel?.deliveryBoys![0].name ?? "",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: AppSizes.textSizeMedium,
                          color: AppColors.textColorSecondary),
                    ),
                    const SizedBox(
                      height: AppSizes.spacingTiny,
                    ),
                    Text(
                      '${localizations?.translate(AppStringConstant.otpCode)}: ${orderModel?.deliveryBoys![0].otp}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: AppSizes.textSizeMedium,
                          color: AppColors.textColorPrimary,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: AppSizes.spacingTiny,
                    ),
                    Text(
                      '${localizations?.translate(AppStringConstant.contact)}: ${orderModel?.deliveryBoys![0].mobileNumber}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: AppSizes.textSizeMedium,
                          color: AppColors.textColorSecondary),
                    ),
                    const SizedBox(
                      height: AppSizes.spacingTiny,
                    ),
                    Text(
                      '${localizations?.translate(AppStringConstant.vehicleNumber)}: ${orderModel?.deliveryBoys![0].vehicleNumber}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: AppSizes.textSizeMedium,
                          color: AppColors.textColorSecondary),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: AppSizes.spacingGeneric,
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.spacingTiny),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(localizations
                                ?.translate(AppStringConstant.help)
                                .toUpperCase() ??
                            ""),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.spacingTiny),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(localizations
                                ?.translate(AppStringConstant.track)
                                .toUpperCase() ??
                            ""),
                      ),
                    )),
              ],
            )
          ],
        ),
      ));
}
