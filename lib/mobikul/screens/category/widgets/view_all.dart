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
import 'package:test_new/mobikul/configuration/mobikul_theme.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/helper/utils.dart';

import '../../../constants/app_string_constant.dart';
import '../../../helper/generic_methods.dart';

Widget viewAllButton(BuildContext context, GestureTapCallback onClick) {
  return InkWell(
    onTap: onClick,
    child: Container(
        color: Theme.of(context).cardColor,
        child: OutlinedButton(
          onPressed: onClick,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  Utils.getStringValue(
                      context, AppStringConstant.viewAll)
                      .toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Theme.of(context).colorScheme.outline, fontSize: AppSizes.textSizeTiny))
            ],
          ),
        )
    ),
  );
}
