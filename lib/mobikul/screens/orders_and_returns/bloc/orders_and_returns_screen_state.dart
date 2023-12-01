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
import 'package:test_new/mobikul/models/guestView/guestView.dart';

import '../../../models/orders_and_returns/orders_and_returns_model.dart';

abstract class OrdersAndReturnsState extends Equatable {
  const OrdersAndReturnsState();

  @override
  List<Object?> get props => [];

}


class OrdersAndReturnsInitialState extends OrdersAndReturnsState{}

class OrdersAndReturnsLoadingState extends OrdersAndReturnsState{}

class OrdersAndReturnsEmptyState extends OrdersAndReturnsState{}

class OrdersAndReturnsSuccessState extends OrdersAndReturnsState{
  final GuestView data;
  String? orderId;
  String? message;
  OrdersAndReturnsSuccessState(this.data, this.orderId, this.message);
}

class OrdersAndReturnsErrorState extends OrdersAndReturnsState{
  final String message;
  const OrdersAndReturnsErrorState(this.message);
}