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
import 'package:test_new/mobikul/models/cart/cart_details_model.dart';

abstract class CartScreenState extends Equatable{
  const CartScreenState();

  @override
  List<Object> get props => [];

}

class CartScreenInitial extends CartScreenState{}

class CartScreenSuccess extends CartScreenState{
 final  CartDetailsModel model;

  const CartScreenSuccess(this.model);

  @override
  List<Object> get props => [];
}

class RemoveCartItemSuccess extends CartScreenState {
  const RemoveCartItemSuccess(this.data);

  final BaseModel data;

  @override
  List<Object> get props => [data];
}

class CartToWishlistState extends CartScreenState{
  final BaseModel data;

  const CartToWishlistState(this.data);

  @override
  List<Object> get props => [data];
}

class SetCartEmptyState extends CartScreenState{
  final BaseModel data;

  const SetCartEmptyState(this.data);

  @override
  List<Object> get props => [data];
}

class SetCartItemQtyState extends CartScreenState{
  final BaseModel data;

  const SetCartItemQtyState(this.data);

  @override
  List<Object> get props => [data];
}

class ApplyCouponState extends CartScreenState{
  final BaseModel data;

  const ApplyCouponState(this.data);

  @override
  List<Object> get props => [data];
}

class CartScreenError extends CartScreenState{
  CartScreenError(this._message);
  String? _message;

  // ignore: unnecessary_getters_setters
  String? get message => _message;

  // ignore: unnecessary_getters_setters
  set message(String? message) {
    _message = message;
  }

  @override
  List<Object> get props => [];
}