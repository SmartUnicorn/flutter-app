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
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/app_localizations.dart';

import '../../../models/cart/price_details.dart';

class PriceDetailView extends StatelessWidget {
  PriceDetailView(
      this.totalData,
      this.localizations,
      {
    Key? key,
  }) : super(key: key);

  List<PriceDetails>? totalData;

  final AppLocalizations? localizations;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.size12),
      child: Container(
        color: Theme.of(context).cardColor,
        child: ListTileTheme(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: AppSizes.size12),
          child: ExpansionTile(
            // leading: Icon(Icons.ba),
            // iconColor: Theme.of(context).colorScheme.primary,
            childrenPadding:
            const EdgeInsets.symmetric(horizontal: AppSizes.size12),
            initiallyExpanded: true,
            title:
                Text((localizations?.translate(AppStringConstant.priceDetails,) ?? "").toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
            children: <Widget>[
              ListView.builder(
                shrinkWrap:true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: totalData?.length ?? 0,
                  itemBuilder: (context, index){
                  return _priceItem( totalData?[index], context);
              }),


            ],
          ),
        ),
      ),
    );
  }

  Widget _priceItem(PriceDetails? data, BuildContext context) =>
      Padding(
        padding: const EdgeInsets.only(left:AppSizes.linePadding, right: AppSizes.linePadding, bottom: AppSizes.spacingGeneric),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                data?.title ?? '',
                style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 13,fontWeight: FontWeight.normal)
              ),
            ),
            const Spacer(),
            Text(
              data?.value ?? '',
              style: const TextStyle(
                fontWeight:  FontWeight.normal,
              ),
            ),
          ],
        ),
      );
}