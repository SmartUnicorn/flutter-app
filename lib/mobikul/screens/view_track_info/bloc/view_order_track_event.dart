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

abstract class ViewOrderTrackEvent extends Equatable{
  const ViewOrderTrackEvent();

  @override
  List<Object> get props => [];
}

class ViewOrderTrackDataEvent extends ViewOrderTrackEvent{
  const ViewOrderTrackDataEvent();
}

class ViewOrderTrackFetchEvent extends ViewOrderTrackEvent{
  final String viewOrderShipmentItemsId;
  const ViewOrderTrackFetchEvent(this.viewOrderShipmentItemsId);
}

