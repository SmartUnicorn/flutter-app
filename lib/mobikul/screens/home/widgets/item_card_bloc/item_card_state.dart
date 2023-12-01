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

import 'package:equatable/equatable.dart';
import 'package:test_new/mobikul/models/base_model.dart';

import '../../../../models/homePage/add_to_wishlist_response.dart';

abstract class ItemCardState extends Equatable {
  const ItemCardState();

  @override
  List<Object> get props => [];
}

class ItemCardInitial extends ItemCardState {}

class AddProductToWishlistStateSuccess extends ItemCardState {
  final AddToWishlistResponse wishListModel;
  final String productId;

  const AddProductToWishlistStateSuccess(this.wishListModel,this.productId);

  @override
  List<Object> get props => [];
}

class RemoveFromWishlistStateSuccess extends ItemCardState {
  final BaseModel baseModel;
  final String productId;

  const RemoveFromWishlistStateSuccess(this.baseModel,this.productId);

  @override
  List<Object> get props => [];
}

class WishlistIdleState extends ItemCardState{
}

//Error State
class ItemCardErrorState extends ItemCardState {
  ItemCardErrorState(this._message);

  String? _message;

  String? get message => _message;

  set message(String? message) {
    _message = message;
  }

  @override
  List<Object> get props => [];
}

class ItemCardEmptyState extends ItemCardState {}
