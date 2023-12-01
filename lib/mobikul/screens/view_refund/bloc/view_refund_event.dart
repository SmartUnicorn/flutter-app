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

abstract class ViewRefundEvent extends Equatable{
  const ViewRefundEvent();

  @override
  List<Object> get props => [];
}

class ViewRefundFetchEvent extends ViewRefundEvent{
  const ViewRefundFetchEvent();
}

class ViewRefundDetailFetchEvent extends ViewRefundEvent{
  final String viewRefundItemsId;
  const ViewRefundDetailFetchEvent(this.viewRefundItemsId);
}

