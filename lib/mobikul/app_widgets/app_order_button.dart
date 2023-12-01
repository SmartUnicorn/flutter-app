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

import '../configuration/mobikul_theme.dart';
import '../constants/app_constants.dart';
import '../constants/app_string_constant.dart';
import '../helper/app_localizations.dart';

Widget commonOrderButton(BuildContext context, AppLocalizations? _localizations,
    String amount, VoidCallback onPressed,
    {Color color = Colors.white,
    String title = AppStringConstant.proceed}) {
  return Container(
    height: 70,
    color: Theme.of(context).cardColor,
    padding: const EdgeInsets.all(AppSizes.size8),
    child: Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                _localizations?.translate(AppStringConstant.amountToBePaid) ??
                    "",
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(fontSize: AppSizes.size12),
              ),
              Text(amount,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontWeight: FontWeight.bold))
            ],
          ),
        ),
        const SizedBox(
          width: 50,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(
              (_localizations?.translate(title) ?? "").toUpperCase(),
              style: const TextStyle(color: AppColors.white),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    ),
  );
}
