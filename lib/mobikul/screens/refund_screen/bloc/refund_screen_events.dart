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

abstract class RefundScreenEvent extends Equatable{
  const RefundScreenEvent();

  @override
  List<Object> get props => [];
}

class RefundScreenDataFetchEvent extends RefundScreenEvent{
  final String page;
  const RefundScreenDataFetchEvent(this.page);
}

class RefundDetailsFetchEvent extends RefundScreenEvent{
  final String invoiceId;
  const RefundDetailsFetchEvent(this.invoiceId);
}
