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

abstract class OrderShipmentScreenEvent extends Equatable{
  const OrderShipmentScreenEvent();

  @override
  List<Object> get props => [];
}

class OrderShipmentScreenDataFetchEvent extends OrderShipmentScreenEvent{
  final String page;
  const OrderShipmentScreenDataFetchEvent(this.page);
}

class OrderShipmentDetailsFetchEvent extends OrderShipmentScreenEvent{
  final String orderShipmentId;
  const OrderShipmentDetailsFetchEvent(this.orderShipmentId);
}

class OrderShipmentTrackFetchEvent extends OrderShipmentScreenEvent{
  final String viewOrderShipmentItemsId;
  const OrderShipmentTrackFetchEvent(this.viewOrderShipmentItemsId);
}
