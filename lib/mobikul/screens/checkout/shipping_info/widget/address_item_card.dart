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
import 'package:flutter_html/flutter_html.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';

import '../../../../configuration/mobikul_theme.dart';

Widget addressItemWithHeading(
    BuildContext context, String title, String address,
    {Widget? addressList,
    Widget? actions,
    bool? showDivider,
    bool? isElevated,
    VoidCallback? callback}) {
  return Container(
    color: Theme.of(context).cardColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.size8),
          child: Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        if (showDivider ?? false)
          const Divider(
            thickness: 0,
            color: AppColors.white,
            height: 1,
          ),
        addressList ??
            addressItemCard(address, context,
                actions: actions, isElevated: isElevated, callback: callback)
      ],
    ),
  );
}

Widget addressItemCard(String address, BuildContext context,
    {Widget? actions,
    bool? isElevated,
    VoidCallback? callback,
    bool? isSelected}) {
  return Card(
    color: Theme.of(context).cardColor,
    elevation: (isElevated ?? true) ? AppSizes.linePadding : 0,
    margin: const EdgeInsets.fromLTRB(0, AppSizes.size8, 0, 0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if ((address ?? "").isNotEmpty)
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: (isSelected ?? false) ? Border.all() : null,
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(AppSizes.size8),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: (callback != null) ? callback : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Html(
                    data: address,
                    style: {
                      "body": Style(
                        fontSize:  FontSize(AppSizes.textSizeMedium),
                      ),
                    },
                  )),
                  if (callback != null)
                    const Icon(
                      Icons.navigate_next,
                      color: AppColors.lightGray,
                    )
                ],
              ),
            ),
          ),
        if ((address ?? "").isNotEmpty)
          const Divider(
            thickness: 0.5,
            height: 0.5,
          ),
        if (actions != null) actions,
      ],
    ),
  );
}

Widget actionContainer(
  BuildContext context,
  VoidCallback leftCallback,
  VoidCallback rightCallback, {
  IconData? iconLeft,
  IconData? iconRight,
  String? titleLeft,
  String? titleRight,
  bool? isNewAddress,
  bool? hasAddress = true,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSizes.size8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (hasAddress ?? false)
          SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width / 2.5,
              child: OutlinedButton(
                onPressed: leftCallback,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconLeft ?? Icons.edit,
                      size: AppSizes.size16,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    const SizedBox(
                      width: AppSizes.linePadding,
                    ),
                    Text((titleLeft ?? '').toUpperCase(),
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.outline,
                            fontSize: AppSizes.textSizeTiny
                        ))
                  ],
                ),
              )),
        if (isNewAddress ?? false)
          SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width / 2.5,
              child: OutlinedButton(
                onPressed: rightCallback,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconRight ?? Icons.add,
                      size: AppSizes.size16,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    const SizedBox(
                      width: AppSizes.linePadding,
                    ),
                    Text(
                        // _localizations?.translate(AppStringConstant.newAddress) ??
                        (titleRight ?? "").toUpperCase(),
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.outline,
                            fontSize: AppSizes.textSizeTiny))
                  ],
                ),
              )),
      ],
    ),
  );
}
