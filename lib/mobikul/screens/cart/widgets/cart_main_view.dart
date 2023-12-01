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
import 'package:test_new/mobikul/app_widgets/app_dialog_helper.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/constants/app_routes.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/app_localizations.dart';
import 'package:test_new/mobikul/models/cart/cart_details_model.dart';
import 'package:test_new/mobikul/screens/cart/widgets/price_detail_view.dart';
import 'package:test_new/mobikul/screens/home/widgets/product_carasoul_widget_type2.dart';
import '../bloc/cart_screen_bloc.dart';
import '../bloc/cart_screen_event.dart';
import '../bloc/cart_screen_state.dart';
import 'cart_icon_button.dart';
import 'cart_product_item.dart';
import 'discount_view.dart';

class CartMainView extends StatelessWidget {
  const CartMainView(this.model, this.localizations, this.bloc, {Key? key})
      : super(key: key);

  final CartDetailsModel? model;
  final AppLocalizations? localizations;
  final CartScreenBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // products list view
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: AppSizes.size16),
              child: Container(
                color: Theme.of(context).cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.size8,
                          vertical: AppSizes.linePadding),
                      child: Text(
                          "${model?.items?.length.toString()} ${(localizations?.translate(AppStringConstant.items) ?? "").toUpperCase()}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(fontWeight: FontWeight.w600)),
                    ),
                    const Divider(thickness: 1),
                  ],
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) =>
                  CartProductItem(model?.items?[index], localizations, bloc),
              itemCount: (model?.items?.length ?? 0),
            ),
          ],
        ),

        /// vouchers listview

        DiscountView(
          discountApplied: model?.couponCode?.isNotEmpty ?? false,
          discountCode: model?.couponCode ?? "",
          onClickApply: (discountCode) {
            bloc?.add(ApplyCouponEvent(discountCode.toString() ?? "", 0));
          },
          onClickRemove: (discountCode) {
            bloc?.add(ApplyCouponEvent(model?.couponCode.toString() ?? "", 1));
          },
        ),

        // CartIconButton(
        //   leadingIcon: Icons.update,
        //   title: localizations?.translate(AppStringConstant.updateShoppingCart).toUpperCase() ?? "",
        //   onClick: () {
        //     bloc?.add(const CartScreenDataFetchEvent());
        //   },
        // ),
        CartIconButton(
          leadingIcon: Icons.arrow_forward,
          title: localizations?.translate(AppStringConstant.continueShopping) ??
              "",
          onClick: () {
            Navigator.pushNamed(context, AppRoutes.bottomTabBar);
          },
        ),
        CartIconButton(
          leadingIcon: Icons.delete_forever,
          title: (localizations?.translate(AppStringConstant.emptyCart) ?? "")
              .toUpperCase(),
          onClick: () {
            AppDialogHelper.confirmationDialog(
                AppStringConstant.emptyCartText, context, localizations,
                title: AppStringConstant.emptyCart, onConfirm: () {
              bloc?.add(SetCartEmpty());
              bloc?.emit(CartScreenInitial());
            });
          },
        ),
        const SizedBox(height: 10.0),
        Container(
          color: Theme.of(context).colorScheme.background,
          child: ProductCarasoulType2((model?.crossSellList ?? []), context, "",
              (localizations?.translate(AppStringConstant.moreChoices) ?? ''),
              isShowViewAll: false),
        ),

        PriceDetailView(model?.totalsData ?? [], localizations),
      ],
    );
  }
}
