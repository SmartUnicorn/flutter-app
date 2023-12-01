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

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:test_new/mobikul/configuration/mobikul_theme.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/app_storage_pref.dart';
import 'package:test_new/mobikul/helper/utils.dart';
import 'package:test_new/mobikul/screens/product_detail/bloc/product_detail_screen_bloc.dart';
import 'package:test_new/mobikul/screens/product_detail/bloc/product_detail_screen_state.dart';
import 'package:test_new/mobikul/screens/product_detail/widgets/rating_container.dart';

import '../../../app_widgets/app_dialog_helper.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/bottom_sheet_helper.dart';
import '../../../models/productDetail/product_detail_page_model.dart';
import '../bloc/product_detail_screen_events.dart';

class ProductPageBasicDetailsView extends StatefulWidget {
  final ProductDetailPageModel? product;
  final ValueChanged<bool>? callback;
  bool addedToWishlist = false;
  ProductDetailScreenBloc? productPageBloc;

  ProductPageBasicDetailsView(this.addedToWishlist, this.productPageBloc,
      {super.key, this.product, this.callback});

  @override
  State<StatefulWidget> createState() {
    return ProductPageBasicDetailsViewState();
  }
}

class ProductPageBasicDetailsViewState
    extends State<ProductPageBasicDetailsView> {
  @override
  void didChangeDependencies() {}

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).cardColor,
        padding: EdgeInsets.all(15.0),
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.product?.name ?? '',
                style: Theme.of(context).textTheme.headline2),
            SizedBox(height: AppSizes.size8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Visibility(
                    visible: (widget.product?.hasPrice() ?? true),
                    child: Row(
                      children: [
                        Text(
                          (widget.product?.formattedFinalPrice ?? '').isNotEmpty
                              ? widget.product?.formattedFinalPrice ?? ''
                              : '',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          width: AppSizes.size8,
                        ),
                      ],
                    )),

                Visibility(
                    visible: (widget.product?.hasSpecialPrice() ?? false),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: AppSizes.linePadding,
                        ),
                        Text(
                          widget.product?.formattedPrice ?? '',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Theme.of(context).textTheme.headline4!.color,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    )),

                // if (widget.product?.hasSpecialPrice()??true)
                //   Text(
                //     widget.product?.formattedPrice.toString() ?? '',
                //     style: TextStyle(
                //       fontSize: 12.0,
                //       color: Theme.of(context).textTheme.headline4!.color,
                //       decoration: TextDecoration.lineThrough,
                //     ),
                //   ),

                if (widget.product?.hasSpecialPrice() == true)
                  SizedBox(
                    width: AppSizes.size8,
                  ),
                if (widget.product?.hasSpecialPrice() == true)
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        border: Border.all(
                          color: AppColors.green,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: AppSizes.spacingGeneric,
                          bottom: AppSizes.spacingGeneric,
                          left: AppSizes.spacingGeneric,
                          right: AppSizes.spacingGeneric),
                      child: Text(
                        "${widget.product?.getDiscountPercentage()}${Utils.getStringValue(context, AppStringConstant.offPercentage)}",
                        style: TextStyle(color: AppColors.green),
                      ),
                    ),
                  ),

                Visibility(
                    visible: (widget.product?.hasMinPrice() ?? false),
                    child: Row(
                      children: [
                        Text(
                          (widget.product?.formattedMinPrice ?? '').isNotEmpty
                              ? widget.product?.formattedMinPrice ?? ''
                              : '',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          width: AppSizes.spacingTiny,
                        ),
                      ],
                    )),

                Visibility(
                    visible: (widget.product?.hasMaxPrice() ?? false),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: AppSizes.linePadding,
                        ),
                        Text(
                          '-',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          width: AppSizes.spacingTiny,
                        ),
                        Text(
                          (widget.product?.formattedMaxPrice ?? '').isNotEmpty
                              ? widget.product?.formattedMaxPrice ?? ''
                              : '',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          width: AppSizes.size8,
                        ),
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: AppSizes.size6,
            ),
            Row(
              children: [
                ((widget.product?.reviewCount ?? 0) > 0)
                    ? productReviews(widget.product?.reviewCount ?? 0,
                        widget.product?.rating ?? 0)
                    : Text(Utils.getStringValue(context, '')),
                Padding(
                  padding: const EdgeInsets.only(left: AppSizes.paddingNormal),
                  child: InkWell(
                    onTap: () {
                      reviewBottomModalSheet(
                          context,
                          widget.product?.name ?? '',
                          widget.product?.thumbNail ?? '',
                          widget.product?.id ?? "",
                          widget.product?.ratingFormData ?? []);
                    },
                    child: ((widget.product?.reviewCount ?? 0) > 0)
                        ? Text(
                            Utils.getStringValue(
                                    context, AppStringConstant.addReview)
                                .toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .button
                                ?.copyWith(color: AppColors.blue),
                          )
                        : Text(
                            Utils.getStringValue(
                                    context,
                                    AppStringConstant
                                        .beTheFirstToReviewThisProduct)
                                .toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .button
                                ?.copyWith(color: AppColors.blue),
                          ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12.0,
            ),
            Text(widget.product?.availability?.toUpperCase() ?? '',
                style: Theme.of(context).textTheme.headline5),
            SizedBox(
              height: 12.0,
            ),
            Divider(),
            actionContainer()
          ],
        ));
  }

  Widget productReviews(int totalReview, double avgReview) {
    return Row(
      children: [
        RatingContainer((widget.product?.rating?.toDouble() ?? 0.0)),
        SizedBox(
          width: AppSizes.size8,
        ),
        Text(
          "$totalReview ${Utils.getStringValue(context, AppStringConstant.reviews)}",
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }

  Widget actionContainer() {
    return SizedBox(
        height: 50,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: () {
                    if (appStoragePref.isLoggedIn() == true) {
                      !widget.addedToWishlist
                          ? widget.productPageBloc?.add(AddToWishlistEvent(
                              widget.product?.id.toString() ?? ''))
                          : AppDialogHelper.confirmationDialog(
                              Utils.getStringValue(context,
                                  AppStringConstant.removeItemFromWishlist),
                              context,
                              AppLocalizations.of(context),
                              title: Utils.getStringValue(
                                  context, AppStringConstant.removeItem),
                              onConfirm: () async {
                              widget.productPageBloc?.add(
                                  RemoveFromWishlistEvent(widget
                                      .product?.wishlistItemId
                                      .toString()));
                            });
                    } else {
                      AppDialogHelper.confirmationDialog(
                          Utils.getStringValue(context,
                              AppStringConstant.loginRequiredToAddOnWishlist),
                          context,
                          AppLocalizations.of(context),
                          title: Utils.getStringValue(
                              context, AppStringConstant.loginRequired),
                          onConfirm: () async {
                        Navigator.of(context).pushNamed(AppRoutes.signInSignUp);
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        (widget.product?.isInWishlist ?? false)
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: (widget.product?.isInWishlist ?? false)
                            ? AppColors.lightRed
                            : Theme.of(context).colorScheme.outline,
                        size: AppSizes.genericIconSize,
                      ),
                      SizedBox(
                        width: AppSizes.size8 / 2,
                      ),
                      Expanded(
                          child: Text(
                        Utils.getStringValue(
                                    context, AppStringConstant.wishList)
                                .toUpperCase() ??
                            '',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                              fontSize: AppSizes.textSizeTiny,
                              overflow: TextOverflow.ellipsis,
                            ),
                        maxLines: 1,
                      )),
                    ],
                  ),
                )),
            const SizedBox(width: 5.0),
            Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: () {
                    if (appStoragePref.isLoggedIn() == true) {
                      widget.productPageBloc?.add(AddToCompareEvent(
                          widget.product?.id.toString() ?? ''));
                    } else {
                      AppDialogHelper.confirmationDialog(
                          Utils.getStringValue(context,
                              AppStringConstant.loginRequiredToAddOnCompare),
                          context,
                          AppLocalizations.of(context),
                          title: Utils.getStringValue(
                              context, AppStringConstant.loginRequired),
                          onConfirm: () async {
                        Navigator.of(context).pushNamed(AppRoutes.signInSignUp);
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.swap_horizontal_circle_outlined,
                        color: Theme.of(context).colorScheme.outline,
                        size: AppSizes.genericIconSize,
                      ),
                      SizedBox(
                        width: AppSizes.size8 / 2,
                      ),
                      Expanded(
                          child: Text(
                        Utils.getStringValue(context, AppStringConstant.compare)
                            .toUpperCase(),
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                              fontSize: AppSizes.textSizeTiny,
                              overflow: TextOverflow.ellipsis,
                            ),
                        maxLines: 1,
                      )),
                    ],
                  ),
                )),
            const SizedBox(width: 5.0),
            Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: () async {
                    await FlutterShare.share(
                        title: widget.product?.name ?? '',
                        text: '',
                        linkUrl: widget.product?.productUrl,
                        chooserTitle: '');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.share,
                        color: Theme.of(context).colorScheme.outline,
                        size: AppSizes.genericIconSize,
                      ),
                      SizedBox(
                        width: AppSizes.size8 / 2,
                      ),
                      Expanded(
                          child: Text(
                        Utils.getStringValue(context, AppStringConstant.share)
                            .toUpperCase(),
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                              fontSize: AppSizes.textSizeTiny,
                              overflow: TextOverflow.ellipsis,
                            ),
                        maxLines: 1,
                      )),
                    ],
                  ),
                )),
          ],
        ));
  }
}
