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
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/models/categoryPage/product_tile_data.dart';

import '../../../app_widgets/app_alert_message.dart';
import '../../../app_widgets/app_dialog_helper.dart';
import '../../../app_widgets/image_view.dart';
import '../../../configuration/mobikul_theme.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_string_constant.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/app_storage_pref.dart';
import '../../../helper/utils.dart';
import 'item_card_bloc/item_card_bloc.dart';
import 'item_card_bloc/item_card_event.dart';
import 'item_card_bloc/item_card_state.dart';

class ItemCard extends StatefulWidget {
  double? imageSize;
  Function? callBack;
  bool isSelected = false;

  final ProductTileData? product;

  ItemCard(
      {this.product, this.imageSize, this.callBack, this.isSelected = false});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool isLoading = true;
  ItemCardBloc? itemCardBloc;

  @override
  Widget build(BuildContext ctx, {Function(String)? callback}) {
    widget.imageSize ??= (AppSizes.deviceWidth / 2.5) - AppSizes.size4;
    itemCardBloc = ctx.read<ItemCardBloc>();
    return BlocBuilder<ItemCardBloc, ItemCardState>(
      builder: (context, currentState) {
        if (currentState is ItemCardInitial) {
          isLoading = true;
        } else if (currentState is ItemCardErrorState) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(
                currentState.message ??
                    Utils.getStringValue(
                        context, AppStringConstant.somethingWentWrong),
                context);
          });
        } else if (currentState is AddProductToWishlistStateSuccess) {
          isLoading = false;
          if (currentState.wishListModel.success == true) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.wishListModel.message ?? '', context);
              itemCardBloc?.emit(WishlistIdleState());
            });
            if (widget.product?.entityId.toString() == currentState.productId) {
              widget.product?.isInWishlist = true;
              widget.product?.wishlistItemId =
                  currentState.wishListModel.itemId;
            }
          } else {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(
                  currentState.wishListModel.message ?? '', context);
            });
          }
          itemCardBloc?.emit(ItemCardEmptyState());
        } else if (currentState is RemoveFromWishlistStateSuccess) {
          isLoading = false;
          if (currentState.baseModel.success == true) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.baseModel.message ?? '', context);
              itemCardBloc?.emit(WishlistIdleState());
            });
            if (widget.product?.wishlistItemId.toString() ==
                currentState.productId) {
              widget.product?.isInWishlist = false;
            }
          } else {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(
                  currentState.baseModel.message ??
                      Utils.getStringValue(
                          context, AppStringConstant.somethingWentWrong),
                  context);
            });
          }
          itemCardBloc?.emit(ItemCardEmptyState());
        }
        return buildUi(ctx);
      },
    );
  }

  Widget buildUi(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Card(
        elevation: AppSizes.size2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.size4)),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.productPage,
              arguments: getProductDataAttributeMap(
                widget.product?.name ?? "",
                widget.product?.entityId.toString() ?? "",
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                ),
                borderRadius: BorderRadius.circular(AppSizes.size6)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(children: <Widget>[
                  Center(
                    child: SizedBox(
                      width: widget.imageSize!,
                      height: widget.imageSize!,
                      child: ImageView(
                        fit: BoxFit.fill,
                        url: widget.product?.thumbNail,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(AppSizes.size6),
                            topLeft: Radius.circular(AppSizes.size6)),
                      ),
                    ),
                  ),
                  Positioned(
                      right: AppSizes.spacingGeneric,
                      top: AppSizes.spacingGeneric,
                      // bottom: AppSizes.spacingTiny,
                      child: InkWell(
                        onTap: () async {
                          if (await appStoragePref.isLoggedIn()) {
                            if (widget.product?.isInWishlist != true) {
                              itemCardBloc?.add(AddToWishlistEvent(
                                  widget.product?.entityId.toString()));
                            } else {
                              print(
                                  "LISTITEMS-------->${widget.product?.wishlistItemId.toString()}");
                              AppDialogHelper.confirmationDialog(
                                  Utils.getStringValue(context,
                                      AppStringConstant.removeItemFromWishlist),
                                  context,
                                  AppLocalizations.of(context),
                                  title: Utils.getStringValue(
                                      context, AppStringConstant.removeItem),
                                  onConfirm: () async {
                                itemCardBloc?.add(RemoveFromWishlistEvent(
                                    widget.product?.wishlistItemId.toString()));
                              });
                            }
                          } else {
                            AppDialogHelper.confirmationDialog(
                                Utils.getStringValue(
                                    context,
                                    AppStringConstant
                                        .loginRequiredToAddOnWishlist),
                                context,
                                AppLocalizations.of(context),
                                title: Utils.getStringValue(
                                    context, AppStringConstant.loginRequired),
                                onConfirm: () async {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.signInSignUp);
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Icon(
                            (widget.product?.isInWishlist ?? false)
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: (widget.product?.isInWishlist ?? false)
                                ? AppColors.lightRed
                                : AppColors.lightGray,
                            size: 18,
                          ),
                        ),
                      )),
                  Positioned(
                    bottom: AppSizes.spacingTiny,
                    left: AppSizes.spacingGeneric,
                    child: (widget.product?.hasSpecialPrice() == true)
                        ? Container(
                            decoration: BoxDecoration(
                                color: AppColors.green,
                                //Colors.white12,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.white12,
                                  //AppColors.green,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: AppSizes.size2,
                                  bottom: AppSizes.size2,
                                  left: AppSizes.linePadding,
                                  right: AppSizes.linePadding),
                              child: Text(
                                "-${widget.product?.getDiscountPercentage()}%",
                                style: TextStyle(color: AppColors.white),
                              ),
                            ),
                          )
                        : Container(),
                  ),
                  if (widget?.product?.isNew ?? true)
                    Positioned(
                        left: AppSizes.linePadding,
                        top: AppSizes.linePadding,
                        child: ColoredBox(
                            color: AppColors.red,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.spacingGeneric,
                                  vertical: AppSizes.spacingTiny),
                              child: Text(
                                  Utils.getStringValue(
                                      context, AppStringConstant.newTest),
                                  style: const TextStyle(
                                      color: AppColors.white,
                                      fontSize: AppSizes.spacingSmall)),
                            )))
                  // if (widget.product?.hasSpecialPrice() == true)
                  //   Positioned(
                  //       right: AppSizes.linePadding,
                  //       top: AppSizes.linePadding,
                  //       child: ColoredBox(
                  //         color: AppColors.discount,
                  //         child: Padding(
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: AppSizes.spacingTiny,
                  //                 vertical: AppSizes.spacingTiny),
                  //             child: Text(
                  //                 "${widget.product?.getDiscountPercentage()}${Utils.getStringValue(context, AppStringConstant.offPercentage)}",
                  //                 style: const TextStyle(
                  //                     color: AppColors.white,
                  //                     fontSize:
                  //                     AppSizes.spacingGeneric))),
                  //       )),
                ]),
                SizedBox(
                  width: widget.imageSize,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: AppSizes.size8,
                        top: AppSizes.size8,
                        right: AppSizes.size8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                                (widget.product?.formattedFinalPrice ?? '')
                                        .isNotEmpty
                                    ? widget.product?.formattedFinalPrice ?? ''
                                    : '',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    ?.copyWith(
                                        fontSize: AppSizes.textSizeMedium)),
                            Visibility(
                                visible: (widget.product?.hasSpecialPrice() ??
                                    false),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: AppSizes.linePadding,
                                    ),
                                    Text(widget.product?.formattedPrice ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                                fontSize:
                                                    AppSizes.textSizeSmall)),
                                  ],
                                )),
                          ],
                        ),

                        (widget.callBack != null)
                            ? ((widget.product?.typeId.toString() ==
                                        "simple") ??
                                    false)
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Checkbox(
                                          value: widget.product?.isChecked ??
                                              widget.isSelected,
                                          onChanged: (value) {
                                            setState(() {
                                              widget.product?.isChecked =
                                                  !(widget.product?.isChecked ??
                                                      false);
                                              // widget.callBack!();
                                              widget.isSelected =
                                                  !widget.isSelected;
                                            });
                                          }),
                                      Expanded(
                                        child: Text(widget.product?.name ?? '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                ?.copyWith(
                                                    fontSize:
                                                        AppSizes.textSizeSmall,
                                                    fontWeight: FontWeight.bold)
                                            // const TextStyle(fontSize: 12.0, color: Colors.black),
                                            ),
                                      )
                                    ],
                                  )
                                : const SizedBox(
                                    height: AppSizes.spacingTiny,
                                  )
                            : const SizedBox(
                                height: AppSizes.spacingTiny,
                              ),
                        // if (widget.product?.hasSpecialPrice() == true)
                        //   Container(
                        //     decoration: BoxDecoration(
                        //         border: Border.all(
                        //           color: AppColors.green,
                        //         )
                        //     ),
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(top: AppSizes.linePadding, bottom: AppSizes.linePadding, left: AppSizes.linePadding, right: AppSizes.linePadding),
                        //       child: Text("${widget.product?.getDiscountPercentage()}"
                        //           "${Utils.getStringValue(context, AppStringConstant.offPercentage)}", style: TextStyle(color: AppColors.green),),
                        //     ),
                        //   ),
                        if (widget.product?.hasSpecialPrice() == true)
                          const SizedBox(
                            height: AppSizes.spacingGeneric,
                          ),
                        Text(widget.product?.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(fontSize: AppSizes.textSizeSmall)
                            // const TextStyle(fontSize: 12.0, color: Colors.black),
                            ),
                        const SizedBox(
                          height: AppSizes.spacingGeneric,
                        ),
                        if (widget.product?.rating.toString() == "0")
                          Text(
                            Utils.getStringValue(
                                context, AppStringConstant.noReviewsYet),
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(fontSize: AppSizes.textSizeTiny),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        if (widget.product?.rating.toString() != "0")
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSizes.spacingTiny,
                                vertical: AppSizes.spacingTiny),
                            decoration: BoxDecoration(
                                color: Utils.ratingBackground(
                                        widget.product?.rating.toString() ??
                                            '') ??
                                   Colors.pink,
                                borderRadius:
                                    BorderRadius.circular(AppSizes.size4)),
                            child: SizedBox(
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: AppSizes.size4,
                                  ),
                                  Text("${widget.product?.rating}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: AppSizes.textSizeSmall,
                                              color: AppColors.white)),
                                  const SizedBox(
                                    width: AppSizes.spacingTiny,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    size: AppSizes.textSizeSmall,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
