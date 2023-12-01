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

abstract class OrderScreenEvent extends Equatable{
  const OrderScreenEvent();

  @override
  List<Object> get props => [];
}

class OrderScreenDataFetchEvent extends OrderScreenEvent{
  final int page;
  final bool isFromDashboard;
  const OrderScreenDataFetchEvent(this.page, this.isFromDashboard);
}

class OrderDetailsFetchEvent extends OrderScreenEvent{
  final String orderId;
  const OrderDetailsFetchEvent(this.orderId);
}

class ReorderEvent extends OrderScreenEvent{
  final String incrementId;
  const ReorderEvent(this.incrementId);
}

class ReviewProductEvent extends OrderScreenEvent{
  String orderId;
  ReviewProductEvent(this.orderId);
}