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
import 'package:test_new/mobikul/helper/app_localizations.dart';

import '../../../constants/app_string_constant.dart';
import '../../../helper/utils.dart';

class AddressHeadingView extends StatelessWidget {
  const AddressHeadingView({
    required this.address,
    required this.title,
    this.onTap,
    this.actions,
    Key? key,
  }) : super(key: key);

  final String address;
  final String title;
  final Widget? actions;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.size8, vertical: AppSizes.size10),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          const Divider(height: 0),
          Card(
            elevation: 0,
            margin: const EdgeInsets.only(top: AppSizes.size8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(AppSizes.size8),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: onTap,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Html(
                            data: address,
                            style: {"body": Style()},
                          ),
                        ),
                        // Text(address),
                        if (onTap != null)
                          const Icon(
                            Icons.navigate_next,
                            color: AppColors.lightGray,
                          )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 0.5,
                  height: 0.5,
                ),
                if (actions != null) actions!,
              ],
            ),
          )
        ],
      ),
    );
  }
}
