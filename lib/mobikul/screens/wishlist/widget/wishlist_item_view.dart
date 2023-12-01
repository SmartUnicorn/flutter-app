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
import 'package:test_new/mobikul/helper/app_localizations.dart';
import 'package:test_new/mobikul/helper/utils.dart';
import 'package:test_new/mobikul/screens/wishlist/bloc/wishlist_screen_bloc.dart';
import 'package:test_new/mobikul/screens/wishlist/bloc/wishlist_screen_event.dart';
import 'package:test_new/mobikul/screens/wishlist/bloc/wishlist_screen_state.dart';
import 'package:test_new/mobikul/screens/wishlist/widget/bottom_wishlist_button.dart';

import '../../../app_widgets/app_dialog_helper.dart';
import '../../../app_widgets/badge_icon.dart';
import '../../../app_widgets/image_view.dart';
import '../../../app_widgets/loader.dart';
import '../../../configuration/mobikul_theme.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/arguments_map.dart';
import '../../../models/wishlist/wishlist_model.dart';
import '../../cart/bloc/cart_screen_event.dart';
import '../../cart/bloc/cart_screen_state.dart';
import '../../cart/widgets/quantity_drop_down.dart';

Widget WishlistItemViewProducts(
    List<WishlistData> items, bloc, BuildContext context, bool? isLoading) {
  return (isLoading ?? false)
      ? const Loader()
      : Visibility(
          visible: items.isNotEmpty,
          child: Stack(children: [
            GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  mainAxisExtent: (AppSizes.deviceWidth / 3) + 130,
                ),
                itemCount: items?.length,
                itemBuilder: (BuildContext context, int index) {
                  IconData? iconRight;

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.productPage,
                        arguments: getProductDataAttributeMap(
                          items?[index].name ?? "",
                          items?[index].entityId.toString() ?? "",
                        ),
                      );
                    },
                    child: Stack(children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          border:
                              Border.all(color: Theme.of(context).dividerColor),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Center(
                                    child: SizedBox(
                                      height: AppSizes.deviceWidth / 3,
                                      child: ImageView(
                                        fit: BoxFit.fill,
                                        url: items?[index].thumbNail,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppSizes.spacingGeneric,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppSizes.spacingGeneric,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Text(
                                          items?[index].formattedFinalPrice ??
                                              "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        // const Spacer(),
                                        // InkWell(
                                        //     onTap: (){
                                        //       Navigator.of(context).pushNamed(AppRoutes.wishlistComment);
                                        //     },
                                        //     child: BadgeIcon(
                                        //       icon: const Icon(
                                        //           Icons.mode_comment_rounded
                                        //       ),
                                        //     ))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: AppSizes.spacingGeneric,
                                          vertical: AppSizes.linePadding),
                                      child: Text(
                                        Utils.parseHtmlString(items?[index].name??""),
                                        // style: Theme.of(context).textTheme.headline3?.copyWith(fontSize: AppSizes.textSizeSmall),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            ?.copyWith(
                                                fontSize:
                                                    AppSizes.textSizeSmall),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      )),

                                  // if(items?[index]?.rating.toString() != "0")
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppSizes.spacingGeneric,
                                        vertical: AppSizes.linePadding),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: AppSizes.spacingTiny,
                                          vertical: AppSizes.spacingTiny),
                                      decoration: BoxDecoration(
                                          color: Utils.ratingBackground(
                                                  items?[index]
                                                          ?.rating
                                                          .toString() ??
                                                      '') ??
                                              Colors.pink,
                                          borderRadius:
                                              BorderRadius.circular(2.0)),
                                      child: SizedBox(
                                        child: Wrap(
                                          alignment: WrapAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 4.0,
                                            ),
                                            Text("${items?[index]?.rating}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: AppSizes
                                                            .textSizeSmall,
                                                        color:
                                                            AppColors.white)),
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
                                  ),

                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: AppSizes.linePadding),
                                  //   child: SizedBox(
                                  //     height: AppSizes.size16,
                                  //     child: QuantityDropDown((value) async {
                                  //       String operator = "";
                                  //       if (int.tryParse(value)! >
                                  //           (items?[index].qty ?? 1)) {}
                                  //       bloc?.add(SetCartItemQuantityEvent(
                                  //           items?[index].productId ?? "",
                                  //           int.tryParse(value) ?? 1));
                                  //       bloc?.emit(WishlistInitialState());
                                  //     }, items?[index].qty?.toInt()
                                  //         // product?.
                                  //         ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: AppSizes.paddingNormal,
                                  right: AppSizes.size6,
                                  bottom: AppSizes.size6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                      width: AppSizes.deviceWidth,
                                      height: AppSizes.size30,
                                      child: InkWell(
                                        onTap: () {
                                          bloc.emit(WishlistActionState());
                                          bloc.add(MoveToCartEvent(
                                              int.parse(items[index]
                                                      .productId!) ??
                                                  0,
                                              items[index].qty ?? 0,
                                              int.parse(items[index].id!) ??
                                                  0));
                                        },
                                        child: Container(
                                          // height: AppSizes.size16,

                                          decoration: BoxDecoration(
                                              color:
                                                  Theme.of(context).buttonTheme.colorScheme?.background,
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .dividerColor,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppSizes.size2)),
                                          child: Center(
                                              child: Text(
                                            Utils.getStringValue(
                                                        context,
                                                        AppStringConstant
                                                            .moveToCart)
                                                    .toUpperCase() ??
                                                '',
                                            style: const TextStyle(
                                                color: AppColors.white,
                                                fontSize: 12),
                                          )),
                                        ),
                                      )

                                      /*TextButton(
                                              onPressed: () {

                                                // bloc.emit(WishlistActionState());
                                                bloc.add(MoveToCartEvent(
                                                    int.parse(items[index].productId!) ?? 0,
                                                    items[index].qty ?? 0,
                                                    int.parse(items[index].id!) ?? 0));

                                                // bloc?.add(const WishlistDataFetchEvent(0));
                                              },
                                              child: Text(
                                                (Utils.getStringValue(
                                                    context,
                                                    AppStringConstant.moveToCart
                                                        .localized())),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w700, color: AppColors.black),
                                              )),*/
                                      ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          top: AppSizes.size10,
                          right: AppSizes.size10,
                          child: GestureDetector(
                            onTap: () {
                              AppDialogHelper.confirmationDialog(
                                  AppStringConstant.removeItemFromWishlist,
                                  context,
                                  AppLocalizations.of(context),
                                  onConfirm: () async {
                                bloc.emit(WishlistActionState());
                                bloc.add(
                                    RemoveItemEvent(items?[index].id ?? "0"));
                                bloc?.add(const WishlistDataFetchEvent(0));
                                // Utils.hideSoftKeyBoard();
                                // bloc?.add(RemoveItemEvent());
                              }, title: AppStringConstant.removeItem);
                            },
                            child: Container(
                              height: AppSizes.size22,
                              width: AppSizes.size22,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(AppSizes.size20),
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )),
                              child: Icon(
                                Icons.close,
                                size: AppSizes.size18,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          )),
                    ]),
                  );
                }),
            const Center(
                child: Visibility(
              visible: false,
              child: Loader(),
            )),
          ]));
}
