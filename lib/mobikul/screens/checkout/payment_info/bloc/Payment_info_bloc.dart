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

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/mobikul/helper/utils.dart';
import 'package:test_new/mobikul/screens/checkout/payment_info/bloc/payment_info_events.dart';
import 'package:test_new/mobikul/screens/checkout/payment_info/bloc/payment_info_repository.dart';
import 'package:test_new/mobikul/screens/checkout/payment_info/bloc/payment_info_state.dart';

class PaymentInfoScreenBloc
    extends Bloc<PaymentInfoScreenEvent, PaymentInfoScreenState> {
  PaymentInfoScreenRepository? repository;

  PaymentInfoScreenBloc({this.repository}) : super(PaymentInfoScreenInitial()) {
    on<PaymentInfoScreenEvent>(mapEventToState);
  }

  @override
  void mapEventToState(PaymentInfoScreenEvent event,
      Emitter<PaymentInfoScreenState> emit) async {
    if (event is GetPaymentInfoEvent) {
      try {
        var model = await repository?.getPaymentInfo(event.shippingMethod);
        if (model != null) {
          emit(GetPaymentMethodSuccess(model));
        } else {
          emit(const PaymentInfoScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(PaymentInfoScreenError(error.toString()));
      }
    }
    if (event is CheckoutAddressFetchEvent) {
      try {
        var model = await repository?.getCheckoutAddress();
        if (model != null) {
          emit(CheckoutAddressSuccess(model));
        } else {
          emit(const PaymentInfoScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(PaymentInfoScreenError(error.toString()));
      }
    } else if (event is PlaceOrderEvent) {
      try {
        var model = await repository?.placeOrder(
            event.paymentMethod, event.billingData);
        if (model != null) {
          if (model.success ?? false) {
            emit(PlaceOrderSuccess(model));
          } else {
            emit(PaymentInfoScreenError(model.message));
          }
        } else {
          emit(const PaymentInfoScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(PaymentInfoScreenError(error.toString()));
      }
    } else if (event is ApplyCouponEvent) {
      try {
        emit(PaymentInfoScreenInitial());
        var model = await repository?.applyCoupon(
            (event as ApplyCouponEvent).couponCode, event.remove);
        if (model != null) {
          if (model?.success ?? false) {
            emit(ApplyCouponState(model));
          } else {
            emit(PaymentInfoScreenError(model?.message ?? ''));
          }
        } else {
          emit(PaymentInfoScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(PaymentInfoScreenError(error.toString()));
      }
    } else if (event is GetQuickPayRedirectLinkEvent) {
      try {
        emit(PaymentInfoScreenInitial());
        var model =
            await repository?.getQuickPayRedirectLink(event.incrementId);
        if (model != null) {
          if (model?.success ?? false) {
            emit(GetQuickPayRedirectLinkSuccess(model));
          } else {
            emit(PaymentInfoScreenError(''));
          }
        } else {
          emit(PaymentInfoScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(PaymentInfoScreenError(error.toString()));
      }
    } else if (event is ChangeAddressEvent) {
      emit(ChangeBillingAddressState());
    }
  }
}
