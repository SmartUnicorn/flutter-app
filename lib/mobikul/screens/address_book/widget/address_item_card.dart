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

class AddressItemCard extends StatelessWidget {
  const AddressItemCard({
    required this.address,
    this.onTap,
    this.actions,
    Key? key,
  }) : super(key: key);

  final String address;
  final Widget? actions;
  final VoidCallback? onTap;
/*  String? cid;
  String categoryName;
  ViewCard(this.cid,this.categoryName, {Key? key}) : super(key: key);

*/

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
