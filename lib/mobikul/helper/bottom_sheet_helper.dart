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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/mobikul/screens/delivery_boy_write_review/bloc/deliveryboy_write_review_screen_state.dart';
import 'package:test_new/mobikul/screens/delivery_boy_write_review/deliveryboy_write_review_screen.dart';
import 'package:test_new/mobikul/screens/language/bloc/language_screen_bloc.dart';
import 'package:test_new/mobikul/screens/language/bloc/language_screen_repository.dart';
import 'package:test_new/mobikul/screens/language/language_screen.dart';
import 'package:test_new/mobikul/screens/view_invoice/bloc/view_invoice_screen_bloc.dart';
import 'package:test_new/mobikul/screens/view_invoice/bloc/view_invoice_screen_repository.dart';
import 'package:test_new/mobikul/screens/view_invoice/view_invoice_screen.dart';
import 'package:test_new/mobikul/screens/view_order_shipment/bloc/view_order_shipment_bloc.dart';
import 'package:test_new/mobikul/screens/view_order_shipment/bloc/view_order_shipment_repository.dart';
import 'package:test_new/mobikul/screens/view_order_shipment/view_order_shipment_screen.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/models/checkout/shipping_info/shipping_address_model.dart';
import 'package:test_new/mobikul/screens/checkout/shipping_info/widget/change_address_view.dart';

import '../app_widgets/bottom_sheet.dart';
import '../models/dashboard/UserDataModel.dart';
import '../models/deliveryBoyDetails/delivery_boy_details_model.dart';
import '../models/productDetail/product_detail_page_model.dart';
import '../screens/add_review/add_review_screen.dart';
import '../screens/add_review/bloc/add_review_screen_bloc.dart';
import '../screens/add_review/bloc/add_review_screen_repository.dart';
import '../screens/delivery_boy_write_review/bloc/deliveryboy_write_review_screen_bloc.dart';
import '../screens/delivery_boy_write_review/bloc/deliveryboy_write_review_screen_repository.dart';
import '../screens/login_signup/bloc/signin_signup_screen_bloc.dart';
import '../screens/login_signup/bloc/signin_signup_screen_repository.dart';
import '../screens/login_signup/view/create_account_screen.dart';
import '../screens/login_signup/view/signin_screen.dart';
import '../screens/notifications/bloc/notification_screen_repository.dart';
import '../screens/notifications/bloc/splash_screen_bloc.dart';
import '../screens/notifications/notification_screen.dart';
import '../screens/orders_list/bloc/order_screen_bloc.dart';
import '../screens/orders_list/bloc/order_screen_repository.dart';
import '../screens/view_refund/bloc/view_refund_screen_bloc.dart';
import '../screens/view_refund/bloc/view_refund_screen_repository.dart';
import '../screens/view_refund/view_refund_screen.dart';
import 'app_storage_pref.dart';


/*
* TO open Bottom sheet for login or signup options
*
* */
void signInSignUpBottomModalSheet(
  BuildContext context,
  bool isSignUp,
    bool? isComingFromCart
) {
  showAppModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => BlocProvider(
        create: (context) => SigninSignupScreenBloc(
            repository: SigninSignupScreenRepositoryImp()),
        child: (isSignUp) ?   CreateAnAccount(isComingFromCart??false) :   SignInScreen( isComingFromCart??false)),
  );
}

void reviewBottomModalSheet(
    BuildContext context, String productName, String thumbNail, String productId, List<RatingFormData>? ratingFormData,
    {Function? function}) {
  showAppModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocProvider(
        create: (context) =>
            AddReviewScreenBloc(repository: AddReviewRepositoryImp()),
        child: AddReviewScreen(productName, thumbNail, productId, ratingFormData),
      )).then((value) {
    if (value == true && function != null) {
      function();
    }
  });
}

void deliveryboyReviewBottomModalSheet(
    BuildContext context,
    String deliveryBoyId,
    int customerId,
    AssignedDeliveryBoyDetails? assignedDeliveryBoyDetails,
    String orderId,
    {Function? function}) {
  showAppModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocProvider(
        create: (context) =>
            DeliveryboyReviewReviewScreenBloc(repository: DeliveryboyWriteReviewRepositoryImp()),
        child: DeliveryboyWriteReviewScreen(deliveryBoyId, customerId.toString(), assignedDeliveryBoyDetails, orderId),
      )).then((value) {
    if (value == true && function != null) {
      function();
    }
  });
}

void notificationBottomModelSheet(BuildContext context) {
  showAppModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) =>
          BlocProvider(
            create: (context) =>
                NotificationScreenBloc(
                    repository: NotificationScreenRepositoryImp()),
            child: const NotificationScreen(),
          ));
}


void languageBottomModelSheet(BuildContext context) {
  showAppModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) =>const LanguageScreen());
}

void viewInvoiceBottomModelSheet(BuildContext context,String? invoiceId, String? orderId) {
  showAppModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) =>
          BlocProvider(
            create: (context) =>
                ViewInvoiceBloc(repository: ViewInvoiceScreenRepositoryImp()),
            child: ViewInvoiceScreen(orderId,invoiceId,""),
          )
  );
}

void viewRefundBottomModelSheet(BuildContext context,String? invoiceId, String? orderId) {
  showAppModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) =>
          BlocProvider(
            create: (context) =>
                ViewRefundBloc(repository: ViewRefundScreenRepositoryImp()),
            child: ViewRefundScreen(orderId,invoiceId,""),
          )
  );
}


void viewShipmentBottomModelSheet(BuildContext context, String? orderId, String? shipmentId) {
  showAppModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) =>
          BlocProvider(
            create: (context) =>
                ViewOrderShipmentBloc(
                    repository: ViewOrderShipmentScreenRepositoryImp()),
            child: ViewOrderShipmentScreen(orderId, shipmentId),
          )
  );
}

  void shippingAddressModelBottomSheet(
      BuildContext context, Function(String) onTap, ShippingAddressModel? addresses) {
    showAppModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) =>
            SizedBox(
              height:
              AppSizes.deviceHeight -
                  WidgetsBinding.instance!.window.padding.top,
              child: ShowAddressList(onTap, addresses),
            ));

}

