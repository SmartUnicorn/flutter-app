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
import 'package:test_new/mobikul/configuration/mobikul_theme.dart';

import '../../../../constants/app_constants.dart';

Widget checkoutProgressLine(bool isFromShipping, BuildContext context) {
  return Row(
    children: [
      Container(
        height: AppSizes.size4,
        width: AppSizes.deviceWidth / 2,
        color: Theme.of(context).iconTheme.color,
      ),
      Container(
        height: AppSizes.size4,
        width: AppSizes.deviceWidth / 2,
        color: isFromShipping
            ? AppColors.lightPrimaryColor1
            : Theme.of(context).iconTheme.color,
      )
    ],
  );
}
