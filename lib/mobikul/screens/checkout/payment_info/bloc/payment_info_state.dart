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
import 'package:test_new/mobikul/models/checkout/payment_info/payment_info_model.dart';
import 'package:test_new/mobikul/models/checkout/place_order/place_order_model.dart';
import 'package:test_new/mobikul/models/checkout/quick_pay/quick_pay_model.dart';
import 'package:test_new/mobikul/screens/checkout/payment_info/payment_info_screen.dart';

import '../../../../models/base_model.dart';
import '../../../../models/checkout/shipping_info/shipping_address_model.dart';

abstract class PaymentInfoScreenState {
  const PaymentInfoScreenState();

  @override
  List<Object> get props => [];
}

class PaymentInfoScreenInitial extends PaymentInfoScreenState {}

class PaymentInfoScreen extends PaymentInfoScreenState {}

class GetPaymentMethodSuccess extends PaymentInfoScreenState {
  final PaymentInfoModel? paymentModel;
  const GetPaymentMethodSuccess(this.paymentModel);

  @override
  List<Object> get props => [];
}

class CheckoutAddressSuccess extends PaymentInfoScreenState {
  final ShippingAddressModel model;

  const CheckoutAddressSuccess(this.model);

  @override
  List<Object> get props => [];
}

class PaymentInfoScreenError extends PaymentInfoScreenState {
  const PaymentInfoScreenError(this.message);
  final String? message;
}

class PlaceOrderSuccess extends PaymentInfoScreen {
  final PlaceOrderModel placeOrderModel;
  PlaceOrderSuccess(this.placeOrderModel);
}

class ChangeBillingAddressState extends PaymentInfoScreen {
  ChangeBillingAddressState();
}

class ApplyCouponState extends PaymentInfoScreen {
  final BaseModel data;

  ApplyCouponState(this.data);

  @override
  List<Object> get props => [data];
}

class GetQuickPayRedirectLinkSuccess extends PaymentInfoScreenState {
  final QuickPayModel data;
  const GetQuickPayRedirectLinkSuccess(this.data);

  @override
  List<Object> get props => [];
}

class PaymentInfoScreenEmptyState extends PaymentInfoScreenState {}
