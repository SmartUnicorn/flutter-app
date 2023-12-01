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
import 'package:test_new/mobikul/models/order_details/order_detail_model.dart';

abstract class RefundScreenState extends Equatable {
  const RefundScreenState();

  @override
  List<Object> get props => [];
}

class RefundScreenInitial extends RefundScreenState{}

class RefundScreenSuccess extends RefundScreenState{
  final Creditmemo creditmemoListData;
  const RefundScreenSuccess(this.creditmemoListData);
}

class RefundScreenError extends RefundScreenState{
  final String message;
  const RefundScreenError(this.message);
}



