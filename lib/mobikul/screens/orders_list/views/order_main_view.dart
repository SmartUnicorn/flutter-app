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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/mobikul/app_widgets/dialog_helper.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/utils.dart';
import 'package:test_new/mobikul/screens/orders_list/bloc/order_screen_bloc.dart';
import 'package:test_new/mobikul/screens/orders_list/bloc/order_screen_events.dart';

import '../../../app_widgets/image_view.dart';
import '../../../configuration/mobikul_theme.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/bottom_sheet_helper.dart';
import '../../../models/order_list/order_list_model.dart';
import '../bloc/order_screen_state.dart';

Widget orderMainView(
    BuildContext context,
    List<OrderListData>? orders,
    AppLocalizations? localizations,
    Function(String orderId) reorderCallback,
    Function(String orderId) reviewCallback,
    ScrollController controller,
    {ScrollPhysics scrollPhysics = const AlwaysScrollableScrollPhysics()}) {
  return ListView.separated(
    controller: controller,
    shrinkWrap: true,
    physics: scrollPhysics,
    itemBuilder: (ctx, index) => orderItem(context, orders?[index],
        localizations, reorderCallback, reviewCallback),
    separatorBuilder: (ctx, index) => const SizedBox(
      height: 10.0,
    ),
    itemCount: (orders?.length ?? 0),
  );
}

Widget orderItem(
    BuildContext context,
    OrderListData? item,
    AppLocalizations? localizations,
    Function(String) reorderCallback,
    Function(String) reviewCallback) {
  return Container(
    color: Theme.of(context).cardColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: AppSizes.deviceWidth / 3,
              width: AppSizes.deviceWidth / 3,
              child: ImageView(
                url: item?.itemImageUrl,
              ),
            ),
            const SizedBox(width: AppSizes.paddingGeneric),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("#${item?.orderId.toString() ?? " "}",
                    style: Theme.of(context).textTheme.headline2
                    // .copyWith(fontSize: AppSizes.textSizeLarge, color: AppColors.textColorPrimary),
                    ),
                const SizedBox(height: AppSizes.size8),
                statusContainer(
                    context, item?.status ?? '', item?.statusColorCode ?? ''),
                const SizedBox(height: AppSizes.size8),
                Text(item?.date ?? '',
                    style: Theme.of(context).textTheme.subtitle2
                    // ?.copyWith(fontSize: AppSizes.textSizeMedium, color: AppColors.textColorSecondary),
                    ),
                const SizedBox(height: AppSizes.size8),
                Text(item?.orderTotal ?? "0.00",
                    style: Theme.of(context).textTheme.headline2
                    // ?.copyWith(fontSize: AppSizes.textSizeLarge, color: AppColors.textColorPrimary)
                    ),
                const SizedBox(height: AppSizes.size8),
              ],
            ),
          ],
        ),
        actionContainer(
          context,
          () {
            Navigator.of(context).pushNamed(
              AppRoutes.orderDetail,
              arguments: item?.orderId.toString() ?? "",
            );
          },
          () {
            reorderCallback(item?.orderId ?? '');
          },
          () {
            reviewCallback(item?.orderId ?? '');
          },
          titleLeft:
              localizations?.translate(AppStringConstant.details).toUpperCase(),
          titleCenter:
              localizations?.translate(AppStringConstant.reorder).toUpperCase(),
          titleRight:
              localizations?.translate(AppStringConstant.review).toUpperCase(),
          iconLeft: Icons.view_array_outlined,
          iconCenter: Icons.repeat,
          iconRight: Icons.reviews_outlined,
        ),
        const SizedBox(height: AppSizes.size8),
      ],
    ),
  );
}

Widget statusContainer(
    BuildContext context, String status, String statusColorCode) {
  return Container(
    decoration: BoxDecoration(
        color: Utils.orderStatusBackground(status, statusColorCode),
        borderRadius: BorderRadius.circular(AppSizes.size4)),
    padding: const EdgeInsets.symmetric(
        vertical: AppSizes.size8 / 2, horizontal: AppSizes.size8),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
            child: Text(
          status.toUpperCase(),
          style: Theme.of(context).textTheme.headline6?.copyWith(
              color: AppColors.white, fontSize: AppSizes.textSizeMedium),
        )),
      ],
    ),
  );
}

//==Todo change with address card
Widget actionContainer(BuildContext context, VoidCallback leftCallback,
    VoidCallback centerCallback, VoidCallback rightCallback,
    {IconData? iconLeft,
    IconData? iconCenter,
    IconData? iconRight,
    String? titleLeft,
    String? titleCenter,
    String? titleRight}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSizes.size8),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 40,
            margin: const EdgeInsets.only(
                left: AppSizes.spacingTiny, right: AppSizes.spacingTiny),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color:Theme.of(context).buttonTheme.colorScheme?.background,
                //Colors.red,
                // Theme.of(context).bannerTheme.backgroundColor,
                border: Border.all(
                    color: Theme.of(context).dividerColor, width: 1)),
            child: InkWell(
              onTap: leftCallback,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    iconLeft ?? Icons.view_array_outlined,
                    size: AppSizes.size16,
                    color: AppColors.white,
                  ),
                  const SizedBox(
                    width: AppSizes.size4,
                  ),
                  Text(
                    (titleLeft ?? '').toUpperCase(),
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 40,
            margin: const EdgeInsets.only(
                left: AppSizes.spacingTiny, right: AppSizes.spacingTiny),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).buttonTheme.colorScheme?.background,
              border:
                  Border.all(color: Theme.of(context).dividerColor, width: 1),
            ),
            child: InkWell(
              onTap: centerCallback,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    iconCenter ?? Icons.repeat,
                    size: AppSizes.size16,
                    color: AppColors.white,
                  ),
                  const SizedBox(
                    width: AppSizes.size4,
                  ),
                  Text(
                    (titleCenter ?? '').toUpperCase(),
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 40,
            margin: const EdgeInsets.only(
                left: AppSizes.spacingTiny, right: AppSizes.spacingTiny),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).buttonTheme.colorScheme?.background,
              border:
                  Border.all(color: Theme.of(context).dividerColor, width: 1),
            ),
            child: InkWell(
              onTap: rightCallback,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    iconRight ?? Icons.reviews_outlined,
                    size: AppSizes.size16,
                    color: AppColors.white,
                  ),
                  const SizedBox(
                    width: AppSizes.size4,
                  ),
                  Text(
                    (titleRight ?? '').toUpperCase(),
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
