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

import '../constants/app_constants.dart';

Widget commonButton(BuildContext context, VoidCallback onPressed, String text,
    {double? width,
      double? height,
      Color? textColor,
      Color? backgroundColor,
      Color? borderSideColor}) {
  borderSideColor ??= Theme.of(context).colorScheme.onPrimary;
  return OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),

        ) ,
        side: BorderSide(
          color: borderSideColor,
        ),
        minimumSize: Size((width != null) ? width : AppSizes.deviceWidth,
            (height != null) ? height : AppSizes.deviceHeight / 16),
        backgroundColor: backgroundColor),
    child: Text(
      text,
      style: Theme.of(context).textTheme.headline6?.copyWith(color: textColor),
    ),
  );
}
