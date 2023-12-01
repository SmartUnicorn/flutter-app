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
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/constants_helper.dart';
import 'package:test_new/mobikul/helper/utils.dart';
import 'package:test_new/mobikul/models/catalog/sorting_data.dart';

import '../../../app_widgets/image_view.dart';
import '../../../constants/app_constants.dart';
import '../../../helper/bottom_sheet_helper.dart';
import '../../../models/order_details/order_detail_model.dart';

class OptionDetails extends StatefulWidget {
  const OptionDetails(this.item, {Key? key}): super(key: key);
  final OrderItem? item;

  @override
  State<OptionDetails> createState() => _OptionDetailsState();
}

class _OptionDetailsState extends State<OptionDetails> {
  String? groupValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(groupValue);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AppBar(
          elevation: 0,
          title: Text(
            Utils.getStringValue(context, AppStringConstant.optionDetails).toUpperCase(),
              style: Theme.of(context)
                  .textTheme.headline3
                  ?.copyWith(fontSize: AppSizes.textSizeSmall,
                   fontWeight: FontWeight.w500,
                   wordSpacing: 0.5,
                   color: AppColors.white
              )
          ),
          automaticallyImplyLeading: false,
          // Uncomment this if you require a close button
          // leeading: const CloseButton()
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.size14,vertical: AppSizes.size14
          ),
          child: Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Text(Utils.getStringValue(context, AppStringConstant.size),
                        style: Theme.of(context)
                            .textTheme.bodyMedium
                            ?.copyWith(fontSize: AppSizes.textSizeSmall, )
                            // color: AppColors.textColorSecondary)
                    )),
                    Text(" "),
                    Expanded(child: Text("${widget.item?.options??"XL"}",
                        style: Theme.of(context)
                            .textTheme.headline3
                            ?.copyWith(fontSize: AppSizes.textSizeSmall, )
                            // color: AppColors.textColorPrimary)
                    )
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(child: Text(Utils.getStringValue(context, AppStringConstant.color),
                        style: Theme.of(context)
                            .textTheme.bodyMedium
                            ?.copyWith(fontSize: AppSizes.textSizeSmall, )
                            // color: AppColors.textColorSecondary)
                    ),
                    ),
                    Text(" "),
                    Expanded(child: Text("${widget.item?.options??"black"}",
                        style: Theme.of(context)
                            .textTheme.headline3
                            ?.copyWith(fontSize: AppSizes.textSizeSmall,))
                            // color: AppColors.textColorPrimary))
                    )

                  ],
                ),
              ],
            )
          ),
        ),
      ],
    );
  }
}