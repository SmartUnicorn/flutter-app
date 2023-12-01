
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_new/mobikul/helper/app_storage_pref.dart';

import '../constants/app_constants.dart';
import 'image_view.dart';

AppBar appToolBar(String heading, BuildContext context,
    {bool isHomeEnable = false,
      bool isElevated = true,
      bool isLeadingEnable = false,
      List<Widget>? actions,
      VoidCallback? onPressed}) {
  print("TEST__LOG${appStoragePref.getAppLogo()}");
  return AppBar(
    // backgroundColor: Theme.of(context).cardColor,
      leading: isLeadingEnable
          ? IconButton(
          onPressed: () {
            isLeadingEnable ? Navigator.pop(context) : onPressed!();
          },
          icon: const Icon(Icons.clear))
          : null,
      elevation: isElevated ? null : 0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isHomeEnable)
            SizedBox(
              height: AppBar().preferredSize.height / 2,
              width: AppBar().preferredSize.height / 2,
              child: appStoragePref.getAppLogo().isEmpty?
              Image.asset(
                AppImages.appIcon,
                fit: BoxFit.fill,
              ) :
              CachedNetworkImage(
                imageUrl: appStoragePref.getAppLogo() ?? "",
                placeholder: (context, url) => Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        AppImages.placeholder,
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        AppImages.placeholder,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isHomeEnable ? AppSizes.spacingGeneric : 0),
            child: Text(
              heading,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ],
      ),
      actions: actions);
}
