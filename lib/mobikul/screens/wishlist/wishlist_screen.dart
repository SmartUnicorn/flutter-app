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

import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/mobikul/constants/app_routes.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/app_localizations.dart';
import 'package:test_new/mobikul/helper/app_storage_pref.dart';
import 'package:test_new/mobikul/models/wishlist/request/wishlist_product_request.dart';
import 'package:test_new/mobikul/models/wishlist/wishlist_model.dart';
import 'package:test_new/mobikul/screens/wishlist/bloc/wishlist_screen_bloc.dart';
import 'package:test_new/mobikul/screens/wishlist/bloc/wishlist_screen_event.dart';
import 'package:test_new/mobikul/screens/wishlist/bloc/wishlist_screen_state.dart';
import 'package:test_new/mobikul/screens/wishlist/widget/bottom_wishlist_button.dart';
import 'package:test_new/mobikul/screens/wishlist/widget/wishlist_item_view.dart';

import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_bar.dart';
import '../../app_widgets/badge_icon.dart';
import '../../app_widgets/loader.dart';
import '../../app_widgets/lottie_animation.dart';
import '../../constants/app_constants.dart';
import '../../helper/utils.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late bool _loading = false;
  WishlistScreenBloc? _bloc;
  final ScrollController _scrollController = ScrollController();
  int _page = 1;
  WishlistModel? _model;
  List<WishlistData> _products = [];
  late WishlistProductRequest _request;
  String? productId;
  bool _isAction = false;
  int? cartCount = 0;
  Map<String, String>? selectedWishlistProductList = HashMap<String, String>();

  @override
  void initState() {
    // _loading = true;
    // _scrollController = ScrollController().addListener(paginationFunction);
    _bloc = context.read<WishlistScreenBloc>();
    _bloc?.add(WishlistDataFetchEvent(_page));
    _scrollController.addListener(() {
      paginationFunction();
    });
    // _callAPI();

    super.initState();
  }

  void paginationFunction() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent &&
        (_model?.totalCount ?? 0) > _products.length) {
      // setState(() {
      _page++;
      _bloc?.add(WishlistDataFetchEvent(_page));
      // });
    }
  }

  List<Map<String, String>> getupAddAllCartWishlistRequest() {
    List<Map<String, String>> itemData = [];
    Map<String, String> productData = {};
    if (_products.isNotEmpty) {
      for (int i = 0; i < _products.length; i++) {
        productData = HashMap<String, String>();
        setState(() {
          productData["id"] = "${_products[i].id}";
          productData["qty"] = "${_products[i].qty}";
        });
        itemData.add(productData);
      }
    }
    return itemData!;
  }

  bool hasMoreData() {
    var total = 0;
    if (_model != null) {
      total = _model?.totalCount ?? 0;
    } else {
      total = _model?.totalCount ?? 0;
    }
    return (total > _products.length && !_loading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).canvasColor,
      /*appBar: appToolBar(
            Utils.getStringValue(context, AppStringConstant.wishList), context),*/
      appBar: commonAppBar(
          Utils.getStringValue(context, AppStringConstant.wishList)
              .localized() /*_localizations?.translate(AppStringConstant.wishList) ?? ""*/,
          context,
          actions: [
            IconButton(
                onPressed: () {
                  if (_products.isEmpty) {
                    AlertMessage.showError(
                        Utils.getStringValue(
                            context, AppStringConstant.emptyWishListMsg),
                        context);
                  } else {
                    Navigator.pushNamed(context, AppRoutes.wishListSharing);
                  }
                },
                icon: const Icon(
                  Icons.share,
                )),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.cart);
                },
                icon: BadgeIcon(
                  icon: const Icon(Icons.shopping_cart),
                  badgeColor: Colors.red,
                )),
          ]),
      body: BlocBuilder<WishlistScreenBloc, WishlistScreenState>(
        builder: (ctx, currentState) {
          if (currentState is WishlistInitialState) {
            _loading = true;
          } else if (currentState is WishlistScreenSuccess) {
            print("TEST_LOG=page=WishlistScreenSuccess> ${_products.length}");
            _loading = false;
            _isAction = false;
            appStoragePref.setCartCount(appStoragePref.getCartCount());
            _model = currentState.wishlistModel;
            if (_page == 1) {
              _products = _model?.wishList ?? [];
              print("TEST_LOG=page=Lenght> ${_products.length}");
            } else {
              _products.addAll(currentState.wishlistModel.wishList ?? []);
              print("TEST_LOG==Lenght> ${_products.length}");
            }
          } else if (currentState is WishlistActionState) {
            _isAction = true;
          } else if (currentState is MoveToCartSuccess) {
            _loading = false;
            _page = 1;
            cartCount = int.parse(currentState
                .wishlistMovecartResponseModel?.cartCount
                .toString() ??
                "0");
            AppStoragePref().setCartCount(
                currentState.wishlistMovecartResponseModel?.cartCount ?? "0");
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              // setState(() {});
              AlertMessage.showSuccess(
                  currentState.wishlistMovecartResponseModel?.message ?? '',
                  context);
            });
            _bloc?.add(WishlistDataFetchEvent(_page));
          } else if (currentState is RemoveItemSuccess) {
            _loading = false;
            _page = 1;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.baseModel?.message ?? '', context);
            });
            _bloc?.add(WishlistDataFetchEvent(_page));
          } else if (currentState is MoveAllToCartSuccess) {
            _loading = false;
            _page = 1;
            cartCount = int.parse(currentState
                .wishlistAddallcartResponseModel?.cartCount
                .toString() ??
                "0");
            AppStoragePref().setCartCount(
                currentState.wishlistAddallcartResponseModel?.cartCount ?? "0");
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.wishlistAddallcartResponseModel?.message ?? 'Item Moved InTo The Cart',
                  context);
              _bloc?.add(WishlistDataFetchEvent(_page));
              setState(() {});
            });
            _bloc?.emit(CompleteState());
          } else if (currentState is WishlistScreenError) {
            _loading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(currentState.message ?? '', context);
            });
          }
          return _buildUI(_products, context);
        },
      ),
    );
  }

  Widget _buildUI(List<WishlistData>? items, BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Stack(
        children: [
          if (_products.isNotEmpty )
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      controller: _scrollController,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: WishlistItemViewProducts(
                              items!, _bloc, context, _loading))),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    bottomWishlistButton(context, items!, _bloc,
                        _loading /*, getupAddAllCartWishlistRequest()!*/,
                            () {
                          if (!_loading) {
                            _bloc?.add(MoveAllToCartEvent(getupAddAllCartWishlistRequest()));
                          }
                        })
                  ],
                ),
              ],
            ),
          Visibility(
            visible: (_products.isEmpty && (!_loading)),
            child: Center(
              child: LottieAnimation(
                  lottiePath: AppImages.emptyWishlistLottie,
                  title: Utils.getStringValue(
                      context, AppStringConstant.noProductAvailable),
                  subtitle: "",
                  buttonTitle: Utils.getStringValue(
                      context, AppStringConstant.continueShopping),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.bottomTabBar, (route) => false);
                  }),
            ),
          ),
          Visibility(visible: _loading, child: const Loader())
        ],
      ),
    );
  }
}
