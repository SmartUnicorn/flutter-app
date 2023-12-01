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

import '../../../../models/checkout/place_order/billing_data_request.dart';

abstract class PaymentInfoScreenEvent extends Equatable{
  const PaymentInfoScreenEvent();

  @override
  List<Object> get props => [];
}

class  GetPaymentInfoEvent extends PaymentInfoScreenEvent{
  final String shippingMethod;

  const GetPaymentInfoEvent(this.shippingMethod);
}

class CheckoutAddressFetchEvent extends PaymentInfoScreenEvent {
  const CheckoutAddressFetchEvent();

  @override
  List<Object> get props => [];
}

class PlaceOrderEvent extends PaymentInfoScreenEvent{
  final String paymentMethod;
  final String shippingMethod;
  final BillingDataRequest billingData;

  const PlaceOrderEvent(this.paymentMethod, this.shippingMethod, this.billingData);

  @override
  List<Object> get props => [];
}

class ChangeAddressEvent extends PaymentInfoScreenEvent {
  const ChangeAddressEvent();

  @override
  List<Object> get props => [];
}

class ApplyCouponEvent extends PaymentInfoScreenEvent{
  String couponCode;
  final int remove;

  ApplyCouponEvent(this.couponCode, this.remove);
}

class GetQuickPayRedirectLinkEvent extends PaymentInfoScreenEvent {
  final String incrementId;

  const GetQuickPayRedirectLinkEvent(
      this.incrementId,
      );

  @override
  List<Object> get props => [];
}
