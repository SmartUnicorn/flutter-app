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
import '../../../models/invoice_view/invoice_view_model.dart';

Widget ViewInvoiceTotalItems(
    BuildContext context, TotalsData? item) {


  Widget getListItem(String? key, String? value) {
    return Row(
      children: [
        Expanded(child: Text(key!)),
        const Text(" "),
        Expanded(
            child: Text(
          value!,
          textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.headline5,
        )),
      ],
    );
  }

  return Container(
    color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.size8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            const SizedBox(
              height: AppSizes.size8,
            ),

            getListItem(item?.label?.toString(), item?.formattedValue?.toString()),

            const SizedBox(
              height: AppSizes.size8,
            ),

          ],
        ),
      ),
  );
}

