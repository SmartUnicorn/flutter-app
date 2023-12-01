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

Widget orderHeaderLayout(BuildContext context, String heading, Widget child) {
  return Container(
    color: Theme.of(context).cardColor,
    width: AppSizes.deviceWidth,
    padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingMedium),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: AppSizes.spacingGeneric),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading.toUpperCase(),
                style:  Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: AppColors.textColorSecondary, fontSize: AppSizes.textSizeMedium),
              ),
              const SizedBox(
                height: AppSizes.spacingNormal,
              ),
              const Divider(
                thickness: 1,
                height: 1,
              ),
            ],
          ),
        ),
        child
      ],
    ),
  );
}