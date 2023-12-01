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

import '../constants/app_constants.dart';

Widget widgetSpace([int type = 0, double? space = AppSizes.size12]) {
  //for horizontal spacing
  if (type == 1) {
    return SizedBox(
      width: space,
    );
  }
  //for vertical spacing
  else {
    return SizedBox(
      height: space,
    );
  }
}
