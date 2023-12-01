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
import 'package:test_new/mobikul/app_widgets/app_bar.dart';
import 'package:test_new/mobikul/app_widgets/bottom_sheet.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/app_storage_pref.dart';
import 'package:test_new/mobikul/helper/utils.dart';

import '../../app_widgets/AppRestart.dart';
import '../../app_widgets/app_alert_message.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_routes.dart';
import '../../constants/global_data.dart';

void showCurrencyBottomSheet(BuildContext context) {
  var availableLanguages = GlobalData.homePageData?.allowedCurrencies;
  if (availableLanguages != null) {
    showAppModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Scaffold(
        appBar: commonAppBar(
            Utils.getStringValue(context, AppStringConstant.currency), context,
            isLeadingEnable: true, onPressed: () {
          Navigator.pop(context);
        }),
        body: Container(
          color: Theme.of(context).cardColor,
          child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: availableLanguages.length,
              itemBuilder: (context, index) {
                var item = availableLanguages[index];
                return InkWell(
                    onTap: () {
                      if (appStoragePref.getCurrencyCode().toString() !=
                          item.code.toString()) {
                        appStoragePref.setCurrencyCode(item.code ?? "");
                        Utils.clearRecentProducts();
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.splash, (route) => false);
                      }
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSizes.spacingGeneric),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: AppSizes.size16,
                                ),
                                Text(
                                  item.code ?? "",
                                  // style: Theme.of(context).textTheme.headline5?.copyWith(fontSize: AppSizes.textSizeLarge, color: AppColors.textColorPrimary),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3
                                      ?.copyWith(
                                          fontSize: AppSizes.textSizeMedium),
                                ),
                                const SizedBox(
                                  height: AppSizes.linePadding,
                                ),
                                Text(
                                  item.label ?? " ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontSize: AppSizes.textSizeSmall),
                                ),
                                const SizedBox(
                                  height: AppSizes.size4,
                                ),
                              ],
                            ),
                            (appStoragePref.getCurrencyCode().toString() ==
                                    item.code.toString())
                                ? Icon(
                                    Icons.radio_button_checked,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    size: 20,
                                  )
                                : Icon(
                                    Icons.radio_button_off,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    size: 20,
                                  ),
                          ],
                        ),
                      ),
                    ));
              }),
        ),
      ),
    );
  }
}
