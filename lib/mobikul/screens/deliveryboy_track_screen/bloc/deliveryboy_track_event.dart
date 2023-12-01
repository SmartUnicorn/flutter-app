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

abstract class DeliveryboyTrackEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class DeliveryboyPlaceSearchFetchEvent extends DeliveryboyTrackEvent {
  final String query;
  DeliveryboyPlaceSearchFetchEvent(this.query);
}

class DeliveryBoyLocationDetailsFetchEvent extends DeliveryboyTrackEvent{
  int deliveryboyId;
  DeliveryBoyLocationDetailsFetchEvent(this.deliveryboyId);
}

class SearchPlaceInitialEvent extends DeliveryboyTrackEvent{}

class SearchPlaceEvent extends DeliveryboyTrackEvent{
  final String query;
  SearchPlaceEvent(this.query);
}

