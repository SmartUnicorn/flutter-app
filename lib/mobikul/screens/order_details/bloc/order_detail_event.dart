
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

part of 'order_detail_screen_bloc.dart';

abstract class OrderDetailEvent extends Equatable{
  const OrderDetailEvent();

  @override
  List<Object> get props => [];
}

class OrderDetailFetchEvent extends OrderDetailEvent{
  String orderId;
OrderDetailFetchEvent(this.orderId);
}

class ReorderEvent extends OrderDetailEvent{
  final String incrementId;
  const ReorderEvent(this.incrementId);
}
