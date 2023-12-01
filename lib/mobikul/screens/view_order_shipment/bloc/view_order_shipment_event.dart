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

abstract class ViewOrderShipmentEvent extends Equatable{
  const ViewOrderShipmentEvent();

  @override
  List<Object> get props => [];
}

class ViewOrderShipmentFetchEvent extends ViewOrderShipmentEvent{
  const ViewOrderShipmentFetchEvent();
}

class ViewOrderShipmentDetailFetchEvent extends ViewOrderShipmentEvent{
  final String viewOrderShipmentItemsId;
  const ViewOrderShipmentDetailFetchEvent(this.viewOrderShipmentItemsId);
}

